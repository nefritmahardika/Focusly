//
//  ContentView.swift
//  Focusly
//
//  Created by Nefrit Mahardika on 21/06/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: TimerViewModel

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Button {
                    NSApplication.shared.terminate(nil)
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding(.top, 10)
                .padding(.trailing, 10)
            }

            VStack(spacing: 5) {
                sessionTitle
                timerDisplay
                controlButtons
                    .padding(.top, 15)
            }
            .padding(.horizontal, 20)
            .padding(.bottom,20)
            .background(Color.clear)

        }
    }

    @ViewBuilder
    private var sessionTitle: some View {
        Text(viewModel.currentSessionTitle)
            .font(.callout)
            .fontWeight(.bold)
            .foregroundColor(.primary)
    }

    @ViewBuilder
    private var timerDisplay: some View {
        VStack(spacing: 10) {
            Text(viewModel.formattedTime)
                .font(.system(size: 48, weight: .regular, design: .rounded))
                .monospacedDigit()

            // Progress Bar
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.secondary.opacity(0.15))
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 10)
                    .fill(progressRingColor)
                    .frame(width: max(0, 200 * CGFloat(viewModel.progress)), height: 8)
                    .animation(.linear(duration: 1), value: viewModel.progress)
            }
            .frame(width: 200)
        }
    }

    // Buttons
    @ViewBuilder
    private var controlButtons: some View {
        HStack(spacing: 10) {
            switch viewModel.timerState {
            case .stopped:
                Button {
                    viewModel.startFocus()
                } label: {
                    Label("Start", systemImage: "play.circle.fill")
                        .font(.callout)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(progressRingColor)

            case .runningFocus, .runningBreak:
                pauseButton
                stopButton

            case .pausedFocus, .pausedBreak:
                resumeButton
                stopButton
            }
        }
        .padding(.horizontal, 5)
    }

    private var pauseButton: some View {
        Button {
            viewModel.pauseTimer()
        } label: {
            Label("Pause", systemImage: "pause.circle.fill")
                .font(.callout)
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
    }

    private var resumeButton: some View {
        Button {
            viewModel.resumeTimer()
        } label: {
            Label("Resume", systemImage: "play.circle.fill")
                .font(.callout)
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .tint(progressRingColor)
    }

    private var stopButton: some View {
        Button {
            viewModel.stopTimer()
        } label: {
            Label("Stop", systemImage: "xmark.circle.fill")
                .font(.callout)
        }
        .buttonStyle(.bordered)
        .controlSize(.large)
    }

    // Properties
    private var progressRingColor: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.purple, .white]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private var breakProgressGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [.white, .purple]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}
