
import MetalKit

class Plane:Primitive {
    
    var texture: MTLTexture?
    var textureVertices:[TextureVertex]!
    
 //   var fragmentFunctionName: String
 //   var vertexFunctionName: String
    
 //   var renderPipelineState : MTLRenderPipelineState!
    
   // var vertices: [Vertex]!
    
    
 //   var indices: [UInt16]!
    
 //   var touchLocation: float2!
    
//    var vertexBuffer: MTLBuffer!
//    var indexBuffer: MTLBuffer!
    
    //var modelConstants = ModelConstants()
    
    override var vertexDescriptor: MTLVertexDescriptor!{
        let vertexDescriptor = MTLVertexDescriptor()
        
        vertexDescriptor.attributes[0].format = .float3
        vertexDescriptor.attributes[0].offset = 0
        vertexDescriptor.attributes[0].bufferIndex = 0
        
        vertexDescriptor.attributes[1].format = .float4
        vertexDescriptor.attributes[1].offset = MemoryLayout<float3>.stride
        vertexDescriptor.attributes[1].bufferIndex = 0
        
        
        vertexDescriptor.attributes[2].format = .float2
        vertexDescriptor.attributes[2].offset = MemoryLayout<float3>.stride + MemoryLayout<float4>.stride
        vertexDescriptor.attributes[2].bufferIndex = 0
        
        vertexDescriptor.layouts[0].stride = MemoryLayout<TextureVertex>.stride
        
        return vertexDescriptor
    }
    
    override func buildVertices(){
        
        let size: Float = 1.0
        
        textureVertices = [TextureVertex(position: float3(-1,1 ,0), color: float4(1,0.5,0.5 ,1),texture:float2(0,1)),
                    TextureVertex(position: float3(-1, -1 ,0), color: float4(1,0.5,0.5 ,1),texture:float2(0,0)),
                    TextureVertex(position: float3(1, -1 ,0), color: float4(1,0.5,0.5 ,1),texture:float2(1,0)),
                    TextureVertex(position: float3( 1, 1 ,0), color: float4(1,0.5,0.5 ,1),texture:float2(1,1))
            
        ]
        
        indices = [
            0,1,2,
            2,3,0
        ]
        
    }
    
    init(device: MTLDevice , imageName : String) {
      
       super.init(device: device)
        
        vertexFunctionName = "vertex_shader_texture"
        fragmentFunctionName = "fragment_shader_texture"
        
        
        
        self.texture = setTexture(device: device, imageName: imageName)
        
        buildVertices()
        buildBuffers(device: device)
        renderPipelineState =  buildPipelineState(device: device)
        
    }
    
    override func buildBuffers(device: MTLDevice) {
        vertexBuffer = device.makeBuffer(bytes: textureVertices!, length: (textureVertices?.count)! *   MemoryLayout<TextureVertex>.stride , options: [])
        
        indexBuffer = device.makeBuffer(bytes: indices, length: indices.count *  MemoryLayout<UInt16>.size, options: [])
    }
    
   override func draw(commandEncoder: MTLRenderCommandEncoder) {
        commandEncoder.setRenderPipelineState(renderPipelineState!)
        commandEncoder.setVertexBuffer(vertexBuffer, offset: 0, index: 0)
        
        //     commandEncoder.setVertexBytes(&modelConstants, length: MemoryLayout<ModelConstants>.stride, index: 1)
        commandEncoder.setFragmentTexture(texture, index: 0)
        
        commandEncoder.drawIndexedPrimitives(type: .triangle,
                                             indexCount: indices.count,
                                             indexType: .uint16,
                                             indexBuffer: indexBuffer!,
                                             indexBufferOffset:0)
    }
   
  
    
   
   
}


extension Plane: Texturable {
   
}


//extension Plane : Renderable {
////     func draw(commandEncoder: MTLRenderCommandEncoder){
////
////    }
//}




