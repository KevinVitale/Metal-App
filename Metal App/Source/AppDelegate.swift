#if canImport(AppKit)
import AppKit
class AppDelegate: NSObject, NSApplicationDelegate
{
    /*!
     */
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

extension AppDelegate
{
    /*!
     */
    convenience init(for app: NSApplication) {
        self.init()
        app.delegate = self
    }
    
}
#endif
