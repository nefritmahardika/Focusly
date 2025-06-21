# Focusly - A Simple macOS Menu Bar Pomodoro Timer

**Focusly** is a minimalist macOS menu bar application designed to help you manage your focus and break sessions, inspired by techniques like the Pomodoro Technique. It lives quietly in your menu bar, providing quick access to your timer without cluttering your dock or desktop.

---

## ✨ Features

- **Menu Bar Integration**: A discreet icon in your macOS menu bar indicates the current timer state.
- **Popover UI**: Click the menu bar icon to reveal a clean popover with your timer controls and current status.
- **Focus & Break States**: Easily switch between focus sessions and short breaks.
- **Visual State Indicators**: The menu bar icon changes to visually communicate whether you're focusing, on a break, or paused.

---

## 🚀 Getting Started

To get Focusly up and running on your Mac, you'll need Xcode (if building manually) or simply download the precompiled app below.

---

## 📦 Download

If you just want to try the app without building it yourself:

👉 [Download Focusly for macOS (.zip)](https://github.com/nefritmahardika/Focusly/Focusly.zip)

> Unzip and move `Focusly.app` to your `Applications` folder. You may need to allow the app in **System Settings > Privacy & Security** the first time it runs.

---

## 👨‍💻 Usage

Once the app is running:

- **Menu Bar Icon**: Appears in your macOS menu bar (top-right corner).
- **Open Popover**: Click the icon to open the timer popover.
- **Timer Controls**:
  - View current timer state and remaining time.
  - Use **Start / Pause** to control the timer.
  - Use **Reset** to stop and reset the session.
  - (Optional) Use **Start Focus** / **Start Break** buttons if included.
- **Close Popover**: Click outside the popover or the menu bar icon again.
- **Exiting the App**:
  - Right-click (or Control-click) the menu bar icon and select **Quit**, or
  - Add an explicit "Quit" button to your popover for user clarity.

---

## 🛠️ Customization

- **Timer Durations**: Adjust `focusDuration` and `breakDuration` in `TimerViewModel.swift`.
- **Menu Bar Icons**: Modify the `systemSymbolName` values in `AppDelegate.swift` within `updateMenuBarIcon()` to change SF Symbols.

---

## 🤝 Contributing

Contributions are welcome!  
If you have suggestions or find bugs, feel free to open an issue or submit a pull request.

---

