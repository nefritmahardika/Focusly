//
//  TimerState.swift
//  Focusly
//
//  Created by Nefrit Mahardika on 21/06/25.
//

import SwiftUI
import Combine

enum TimerState: Equatable {
    case stopped
    case runningFocus
    case pausedFocus
    case runningBreak
    case pausedBreak
}

@MainActor
class TimerViewModel: ObservableObject {


    @Published var timerState: TimerState = .stopped
    @Published var timeRemaining: TimeInterval = 25 * 60
    @Published var currentSessionTitle: String = "Start Focus with Focusly"
    @Published var progress: Double = 0.0

    private var timer: AnyCancellable?
    private var totalSessionDuration: TimeInterval = 0

    // Timer Interval
    let focusDuration: TimeInterval = 25 * 60
    let breakDuration: TimeInterval = 5 * 60
    let showPopoverPublisher = PassthroughSubject<Void, Never>()

    init() {
        resetTimerState()
    }

    
    // Timer Controls
    func startFocus() {
        timerState = .runningFocus
        currentSessionTitle = "Focus Time"
        totalSessionDuration = focusDuration
        timeRemaining = focusDuration

        startTimer()
    }

    func startBreak() {
        timerState = .runningBreak
        currentSessionTitle = "Break Time"
        totalSessionDuration = breakDuration
        timeRemaining = breakDuration

        startTimer()
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
        resetTimerState()
    }

    func pauseTimer() {
        // We can only pause if a timer is running
        guard timerState == .runningFocus || timerState == .runningBreak else { return }

        timer?.cancel()
        timer = nil

        if timerState == .runningFocus {
            timerState = .pausedFocus
            currentSessionTitle = "Focus Paused"
        } else if timerState == .runningBreak {
            timerState = .pausedBreak
            currentSessionTitle = "Break Paused"
        }
    }

    func resumeTimer() {

        guard timerState == .pausedFocus || timerState == .pausedBreak else { return }

        if timerState == .pausedFocus {
            timerState = .runningFocus
            currentSessionTitle = "Focus Time"
        } else if timerState == .pausedBreak {
            timerState = .runningBreak
            currentSessionTitle = "Break Time"
        }
        startTimer()
    }

    private func startTimer() {
        timer?.cancel()
        timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }

                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    self.progress = 1.0 - (self.timeRemaining / self.totalSessionDuration)
                } else {
                    self.timerCompleted()
                }
            }
    }

    private func timerCompleted() {
        timer?.cancel()
        progress = 1.0
        showPopoverPublisher.send()

        if timerState == .runningFocus {
            startBreak()
        } else {
            stopTimer()
            currentSessionTitle = "Break is Over"
        }
    }

   // Timer Reset
    private func resetTimerState() {
        timerState = .stopped
        timeRemaining = focusDuration
        progress = 0.0
        currentSessionTitle = "Start Focus with Focusly"
        totalSessionDuration = focusDuration
    }


    // Time Format
    var formattedTime: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
