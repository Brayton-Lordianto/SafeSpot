import SwiftUI

// MARK: precomputed vertex ordering for bounding box mesh called in object mesh.
// I chose not to make these lazy so that when the user enters the view they can use it immediately. It is good because rendering the zones is a time-urgent task. 
class ObjectMeshGlobals {
    static let shared = ObjectMeshGlobals()
    
    // Precomputed properties
    let quads: [UInt32]
    let texCoords: [SIMD2<Float>]
    
    private init() {
        let BBOX_VERTEX_COUNT: Int = 6 * 4
        
        // Initialize UV coordinates
        let vertexUV = [
            SIMD2<Float>(0, 1),  // bottom-left
            SIMD2<Float>(1, 1),  // bottom-right
            SIMD2<Float>(1, 0),  // top-right
            SIMD2<Float>(0, 0)   // top-left
        ]
        
        // Initialize quads
        var quadArray = [UInt32]()
        for i in stride(from: 0, to: BBOX_VERTEX_COUNT, by: 4) {
            quadArray += [UInt32(i), UInt32(i+1), UInt32(i+2), UInt32(i+3)]
        }
        quads = quadArray
        
        // Initialize texture coordinates
        var coordArray = [SIMD2<Float>]()
        for _ in 0..<6 {  // 6 faces
            coordArray += vertexUV
        }
        texCoords = coordArray
    }
}
