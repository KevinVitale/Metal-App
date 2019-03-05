#if canImport(AppKit)
import AppKit

class Window<ViewController: NSViewController>: NSWindow
{
    var viewController: ViewController? {
        get { return super.contentViewController as? ViewController }
        set { super.contentViewController = newValue }
    }
    
    override func keyDown(with event: NSEvent) {
        switch (event.charactersIgnoringModifiers, event.modifierFlags.contains(.command)) {
        case ("q", true):
            NSApp.terminate(self)
        default:
            super.keyDown(with: event)
        }
    }
}

extension Window
{
    convenience init(_ viewController: () -> ViewController) {
        self.init(contentViewController: viewController())
        self.makeKeyAndOrderFront(nil)
        self.center()
    }
}

extension NSViewController
{
    final func set(title: String, for window: NSWindow? = NSApp.mainWindow) {
        window?.title = title
    }
}
#endif
