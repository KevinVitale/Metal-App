import AppKit
import SceneKit

// Create 'addDelegate'
//------------------------------------------------------------------------------
let appDelegate = AppDelegate(for: NSApplication.shared)

// Create 'window'
//------------------------------------------------------------------------------
let window = Window { MetalViewController() }
let viewController = window.viewController!

// Reference to 'renderer'
//------------------------------------------------------------------------------
var renderer: SCNRenderer?
let renderingDelegate = RenderingDelegate()

// Update our 'renderer' if 'device' changes
//------------------------------------------------------------------------------
viewController.renderer = { device in
    // If the 'device' changes, re-create our 'renderer'.
    if renderer?.device?.registryID != device.registryID {
        let newRenderer      = SCNRenderer(device: device)
        newRenderer.delegate = renderer?.delegate ?? renderingDelegate
        newRenderer.scene    = renderer?.scene ?? SCNScene(named: "Scenes.scnassets/Scene.scn")
        renderer             = newRenderer
    }
    return renderer
}

// run
//------------------------------------------------------------------------------
NSApp.run()
