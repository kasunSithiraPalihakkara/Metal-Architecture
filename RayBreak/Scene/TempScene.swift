
import MetalKit

class TempScene:Scene {
    
  //   let triangle: Triangle!
 //  let triangle2: Triangle!
    
   //   let plane :Plane!
   //   let plane2 : Plane!
    
    
    
    override init(device: MTLDevice, touchPoint:CGPoint) {
        
       // triangle = Triangle(device: device, color: float4(0.25,0.75,0.75,1.0),touchPoint:touchPoint)
       //  triangle2 = Triangle(device: device, color: float4(0.35,0.55,0.55,0.8))
        
       //  plane = Plane(device: device, imageName: "ttt.jpg")
       //  plane2 = Plane(device: device, imageName: "test.jpg")
        
        super.init(device: device,touchPoint:touchPoint)
        appendChild(touchPoint: touchPoint)
        
        /*triangle.scale(axis: float3(0.78))
        triangle.translate(direction: float3(0.2,0,0))
        triangle.rotate(angle: 90, axis: float3(0,0,1))*/
        
      //  add(child: plane2)
      //  add(child: plane)
        
      //  add(child: triangle)
      //  add(child: triangle2)
        
    }
    
     func appendChild(touchPoint:CGPoint) {
        
        let triangle = Triangle(device: super.device, color: float4(0.25,0.75,0.75,1.0),touchPoint:touchPoint)
        add(child: triangle)
//        let plane = Plane(device: device, imageName: "aa.jpg")
//        add(child: plane)
        
    }
    
    override func render(commandEncoder: MTLRenderCommandEncoder , deltaTime: Float) {
        
        //  triangle.rotate(angle: deltaTime, axis: float3(0,0,1))
        super.render(commandEncoder: commandEncoder, deltaTime: deltaTime)
    }
    
}
