import Foundation

class ThemeObserver {
    init() {
        DistributedNotificationCenter.default().addObserver(
            forName: NSNotification.Name("AppleInterfaceThemeChangedNotification"),
            object: nil,
            queue: nil
        ) { _ in
            let isDark = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
            print(isDark ? "dark" : "light")
            fflush(stdout)
        }
    }
}

let observer = ThemeObserver()
CFRunLoopRun()
