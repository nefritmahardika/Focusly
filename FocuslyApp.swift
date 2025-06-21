//
//  FocuslyApp.swift
//  Focusly
//
//  Created by Nefrit Mahardika on 21/06/25.
//

import SwiftUI

@main
struct FocuslyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
