import AppKit
import SceneKit.ModelIO
import MetalKit

//------------------------------------------------------------------------------
let shader = """
#include <metal_stdlib> \n
using namespace metal;

struct VertexIn {
    float4 position [[ attribute(0) ]];
};

vertex float4 vertex_main(const VertexIn vertex_in [[ stage_in ]]) {
    return vertex_in.position;
}

fragment float4 fragment_main() {
    return float4(1, 0, 0, 1);
}
"""
//------------------------------------------------------------------------------

let appDelegate = AppDelegate(for: NSApplication.shared)

// Create 'window'
let window = Window { MetalViewController() }
let viewController = window.viewController!


var renderer: SCNRenderer?

viewController.renderer = { device in
    if renderer?.device?.registryID != device.registryID {
        let scene = renderer?.scene ?? SCNScene(named: "Scenes.scnassets/Scene.scn")
        renderer = .init(device: device)
        renderer?.scene = scene
    }
    return renderer
    
    /*
    if device?.registryID != encoder.device.registryID {
        device = encoder.device
        library = try device.makeLibrary(source: shader, options: nil)
        (vertex, fragment) = (
            library?.makeFunction(name: "vertex_main")
            , library?.makeFunction(name: "fragment_main")
        )
        
        let sphere = MDLMesh(
            sphereWithExtent: [0.5, 0.75, 0.75]
            , segments: [100, 100]
            , inwardNormals: false
            , geometryType: .triangles
            , allocator: MTKMeshBufferAllocator(device: device))
        
        mesh = try MTKMesh(mesh: sphere, device: device)
        
        let descriptor = MTLRenderPipelineDescriptor()
        descriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        descriptor.vertexFunction = vertex
        descriptor.fragmentFunction = fragment
        descriptor.vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mesh.vertexDescriptor)
        
        pipelineState = try device.makeRenderPipelineState(descriptor: descriptor)
    }
    
    encoder.setRenderPipelineState(pipelineState)
    encoder.setVertexBuffer(mesh.vertexBuffers[0].buffer, offset: 0, index: 0)
    
    guard let submesh = mesh.submeshes.first else {
        return
    }
    
    encoder.setTriangleFillMode(.lines)
    encoder.drawIndexedPrimitives(
        type: .triangle
        , indexCount: submesh.indexCount
        , indexType: submesh.indexType
        , indexBuffer: submesh.indexBuffer.buffer
        , indexBufferOffset: 0
    )
     */
}


// activate `NSApp`
NSApp.setActivationPolicy(.regular)
NSApp.activate(ignoringOtherApps: true)

// run
NSApp.run()

