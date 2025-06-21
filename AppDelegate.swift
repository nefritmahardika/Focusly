//
//  AppDelegate.swift
//  Focusly
//
//  Created by Nefrit Mahardika on 21/06/25.
//

import SwiftUI
import AppKit
import UserNotifications
import Combine


class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var statusItem: NSStatusItem!
    private var popover: NSPopover!

    @MainActor private var timerViewModel = TimerViewModel()
    
    private var cancellables = Set<AnyCancellable>()

    // App Cycle Case
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.accessory)

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        if let button = statusItem.button {
            button.action = #selector(togglePopover)
            button.sendAction(on: [.leftMouseDown, .rightMouseDown])
            button.imagePosition = .imageOnly
        }
        
        self.popover = NSPopover()
        self.popover.behavior = .transient
        self.popover.animates = true
        
        self.popover.contentViewController = NSHostingController(
            rootView: ContentView().environmentObject(timerViewModel)
        )
        
    
        timerViewModel.$timerState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newState in
                self?.updateMenuBarIcon(for: newState)
            }
            .store(in: &cancellables)
        timerViewModel.showPopoverPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.showPopover()
            }
            .store(in: &cancellables)

        updateMenuBarIcon(for: timerViewModel.timerState)
    }

    // UI Functions
    @objc private func togglePopover() {
        guard let button = statusItem.button else { return }
        
        if popover.isShown {
            popover.performClose(nil)
        } else {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            NSApp.activate(ignoringOtherApps: true)
        }
    }
    
     private func showPopover() {
        guard let button = statusItem.button else { return }
        
        if !popover.isShown {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            NSApp.activate(ignoringOtherApps: true)
        }
    }
    
    // Menubar Icons
    private func updateMenuBarIcon(for state: TimerState) {
        guard let button = statusItem.button else { return }
        
        switch state {
        case .stopped:
            button.image = NSImage(systemSymbolName: "asterisk.circle.fill", accessibilityDescription: "Timer stopped")
            button.toolTip = "Focusly: Stopped"
        case .runningFocus:
            button.image = NSImage(systemSymbolName: "asterisk.circle.fill", accessibilityDescription: "Focus session running")
            button.toolTip = "Focusly: Focusing"
        case .pausedFocus:
            button.image = NSImage(systemSymbolName: "pause.circle.fill", accessibilityDescription: "Focus session paused")
            button.toolTip = "Focusly: Focus Paused"
        case .runningBreak:
            button.image = NSImage(systemSymbolName: "cup.and.saucer.fill", accessibilityDescription: "Break time")
            button.toolTip = "Focusly: On Break"
        case .pausedBreak:
            button.image = NSImage(systemSymbolName: "pause.circle.fill", accessibilityDescription: "Break time paused")
            button.toolTip = "Focusly: Break Paused"
        }
    }
}
