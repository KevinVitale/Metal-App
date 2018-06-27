import AppKit
import SceneKit
import MetalKit

class MetalViewController: NSViewController
{
    @IBOutlet var delegate: MTKViewDelegate?
    var renderer: ((MTLDevice) throws -> (SCNRenderer?))? = nil

    private(set) var device: Device? {
        didSet {
            set(title: device?.name ?? "")
        }
    }
    
    @IBAction func changeDevice(_ sender: Any?) {
        defer {
            device?.attach(to: mtkView, delegate: self.delegate)
        }
        
        guard let registryID = device?.registryID
            , let device = DeviceQuery.device(after: registryID) else {
                return self.device = Device(MTLCreateSystemDefaultDevice()!)
        }
        
        self.device = Device(device)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        changeDevice(nil)
    }
}

extension MetalViewController
{
    var mtkView: MTKView {
        return view as! MTKView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        changeDevice(nil)
    }
}

class MetalViewDelegate: NSResponder, MTKViewDelegate
{
    func draw(in view: MTKView) {
        guard let viewController = view.nextResponder as? MetalViewController
            , let descriptor = view.currentRenderPassDescriptor
            , let cmdBuffer = viewController.device?.makeCommandBuffer()
            , let renderer = try? viewController.renderer?(cmdBuffer.device) else {
                return
        }
        
        renderer?.render(
            atTime: renderer?.sceneTime ?? CFAbsoluteTimeGetCurrent()
          , viewport: CGRect(origin: .zero, size: view.drawableSize)
          , commandBuffer: cmdBuffer
          , passDescriptor: descriptor
        )

        cmdBuffer.present(view.currentDrawable!)
        cmdBuffer.commit()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
    }
}
