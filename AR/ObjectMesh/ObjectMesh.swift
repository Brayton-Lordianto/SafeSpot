import SwiftUI
import RealityKit
import ARKit

// meshes that are associated with an object/surface 
class ObjectMesh {
    var textEntity: ModelEntity
    var bboxEntity: ModelEntity 
    public init(_ position: simd_float4x4, _ dimensions: simd_float3, _ textString: String = "", _ safetyCategory: SafetyCategory, _ safetyText: String? = nil, fontColor: UIColor = .black, boxColor: Color = .yellow) { 
        textEntity = ModelEntity()
        bboxEntity = ModelEntity() 
        
        let boxColor = safetyCategory.color
        let textString = safetyText ?? (safetyCategory.displayText ?? "")
        
        // main actor makes ui updates auto on main thread
        // while the other await calls can run on the background.
        Task { @MainActor in
            if textString != "" {
                // create text 
                let text = MeshResource.generateText(
                    textString,
                    extrusionDepth: 0.01,
                    font: .boldSystemFont(ofSize: 0.1),
                    containerFrame: CGRect(x: Int(-dimensions.x / 2), y: 0, width: Int(dimensions.x), height: Int(dimensions.y)),  // Container helps with centering
                    alignment: .center,
                    lineBreakMode: .byWordWrapping
                )
                
                let textMaterial = UnlitMaterial(color: fontColor)
                let textModel = ModelEntity(mesh: text, materials: [textMaterial])
                textEntity = textModel
            }            
            
            /// Create and push the bounding box model 
            // could be a bubble graphics? or just a wireframe box.
            let w = Float(dimensions.x)
            let h = Float(dimensions.y)
            let d = Float(dimensions.z)

            let a:SIMD3<Float> = [-w/2, -h/2, -d/2]  // front bottom left
            let b:SIMD3<Float> = [w/2, -h/2, -d/2]   // front bottom right
            let c:SIMD3<Float> = [w/2, h/2, -d/2]    // front top right
            let D:SIMD3<Float> = [-w/2, h/2, -d/2]   // front top left
            
            let e:SIMD3<Float> = [-w/2, -h/2, d/2]   // back bottom left
            let f:SIMD3<Float> = [w/2, -h/2, d/2]    // back bottom right
            let g:SIMD3<Float> = [w/2, h/2, d/2]     // back top right
            let H:SIMD3<Float> = [-w/2, h/2, d/2]    // back top left
            
            let vertices: [SIMD3<Float>] = [
                // Front face (counter-clockwise from bottom left)
                a, b, c, D,
                
                // Back face (counter-clockwise from bottom left)
                e, f, g, H,
                
                // Left face (counter-clockwise from bottom back)
                e, a, D, H,
                
                // Right face (counter-clockwise from bottom front)
                b, f, g, c,
                
                // Top face (counter-clockwise from front left)
                D, c, g, H,
                
                // Bottom face (counter-clockwise from back left)
                e, f, b, a
            ]
            
            // build mesh descriptor 
            var meshDescriptor = MeshDescriptor(name: "wireframe")
            meshDescriptor.positions = MeshBuffers.Positions(vertices)
            meshDescriptor.primitives = .trianglesAndQuads(triangles: [], quads: ObjectMeshGlobals.shared.quads)
            meshDescriptor.textureCoordinates = .init(ObjectMeshGlobals.shared.texCoords)
            
            guard let wireframeMeshResource = try? MeshResource.generate(from: [meshDescriptor]) else {
                print("failed to load mesh for box")
                return 
            }            
            // Create the glowing texture material
            let material = self.createGlowMaterial(color: boxColor)
            let wireframeMesh = ModelEntity(mesh: wireframeMeshResource, materials: [material])
            bboxEntity = wireframeMesh
        }
    }
}
