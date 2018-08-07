import SceneKit

// 'RenderingDelegate'
//------------------------------------------------------------------------------
class RenderingDelegate: NSObject, SCNSceneRendererDelegate
{
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        // access the 'rootNode'
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

