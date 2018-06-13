

import MetalKit

class Renderer: NSObject {
    
    let device: MTLDevice
    let commandQueue: MTLCommandQueue!
    
    var scenes: [Scene] = []
    var scene: Scene!
    let touchpoint:CGPoint = CGPoint(x: 0, y: 0)
    
    
    
    init(device: MTLDevice) {
        self.device = device
        commandQueue = device.makeCommandQueue()
        super.init()
        
      
     scenes.append(TempScene(device: device, touchPoint: touchpoint))
       

        
    }
    
    func tapReceived(position:CGPoint){
      scenes.append(TempScene(device: device, touchPoint: position))
       print("touchPoint:\(position)")
    }
    
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable,
            let descriptor = view.currentRenderPassDescriptor else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: descriptor)
        
        
        
        let deltaTime = 1 / Float(view.preferredFramesPerSecond)
        
        
        //     scene.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
        
//        for scene in scenes{
//            scene.render(commandEncoder: commandEncoder!, deltaTime: deltaTime)
//        }
//
        let scene = scenes.last
        scene?.render(commandEncoder: commandEncoder! , deltaTime : deltaTime)
 
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    
    
    
}


