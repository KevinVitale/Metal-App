import AppKit
import SceneKit.ModelIO
import MetalKit

// 'RenderingDelegate'
//------------------------------------------------------------------------------
class RenderingDelegate: NSObject, SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let _ = renderer.scene?.rootNode else {
            return
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didApplyAnimationsAtTime time: TimeInterval) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didSimulatePhysicsAtTime time: TimeInterval) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didApplyConstraintsAtTime time: TimeInterval) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, willRenderScene scene: SCNScene, atTime time: TimeInterval) {
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
    }
}

// 'Bundle' Ext.
//------------------------------------------------------------------------------
extension Bundle {
    final func modelAsset(forName name: String, withExtension extension: String) -> MDLAsset? {
        guard let url = url(forResource: name, withExtension: `extension`) else {
            return nil
        }
        return MDLAsset(url: url)
    }
}

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

// activate `NSApp`
//------------------------------------------------------------------------------
NSApp.setActivationPolicy(.regular)
NSApp.activate(ignoringOtherApps: true)

// run
//------------------------------------------------------------------------------
NSApp.run()
