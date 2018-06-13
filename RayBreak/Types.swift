//
//  Types.swift
//  RayBreak
//
//  Created by 4Axis_Admin on 6/1/18.
//  Copyright © 2018 caroline. All rights reserved.
//

import Foundation
import simd

struct Vertex {
    var position: float3
    var color: float4
   
    
}

struct TextureVertex {
    var position: float3
    var color: float4
    var texture:float2
}


struct Constants {
    var animateBy :Float = 0.5
}

struct ModelConstants {
    var modelMatrix = matrix_identity_float4x4
}
