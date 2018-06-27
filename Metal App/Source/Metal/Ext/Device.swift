import MetalKit

struct Device: Equatable
{
    private let device: MTLDevice
    private let queue:  MTLCommandQueue
    
    private weak var delegate: MTKViewDelegate?
    private weak var view: MTKView? {
        willSet {
            view?.releaseDrawables()
        }
        didSet {
            view?.device = device
        }
    }
    
    var name: String {
        return device.name
    }
    
    var registryID: UInt64 {
        return device.registryID
    }
    
    init(_ device: MTLDevice = MTLCreateSystemDefaultDevice()!) {
        self.device = device
        self.queue  = device.makeCommandQueue()!
    }
    
    static func == (lhs: Device, rhs: Device) -> Bool {
        return lhs.device.registryID == rhs.device.registryID
    }
    
    static func == (lhs: Device, rhs: MTLDevice?) -> Bool {
        guard let registryID = rhs?.registryID else {
            return false
        }
        return lhs.device.registryID == registryID
    }

    func makeCommandBuffer() -> MTLCommandBuffer? {
        return queue.makeCommandBuffer()
    }
    
    mutating func attach(to view: MTKView, delegate: MTKViewDelegate? = nil) {
        self.view = view
        self.set(delegate: delegate)
    }
    
    mutating func set(delegate: MTKViewDelegate?) {
        self.view?.delegate = delegate
    }
}

extension Device
{
    func load(shader source: String, options: MTLCompileOptions? = nil) throws -> MTLLibrary {
        return try device.makeLibrary(source: source, options: options)
    }
    
    func pipelineState(for descriptor: MTLRenderPipelineDescriptor) throws -> MTLRenderPipelineState {
        return try device.makeRenderPipelineState(descriptor: descriptor)
    }
}

extension Device
{
    func allocator() -> MTKMeshBufferAllocator {
        return .init(device: device)
    }
    
    func mesh(for model: MDLMesh) throws -> MTKMesh {
        return try MTKMesh(mesh: model, device: device)
    }
}

