import SwiftUI
import RealityKit

extension ObjectMesh { 
    @MainActor public func createGlowMaterial(color: Color = .green) -> UnlitMaterial {
        let renderer = ImageRenderer(content: GlowEdgeView(color: color))
        
        // Ensure we have a CGImage
        guard let cgImage = renderer.cgImage else {
            return UnlitMaterial()
        }
        
        // save the cgimage
        // let uiimage = UIImage(cgImage: cgImage)
        // UIImageWriteToSavedPhotosAlbum(uiimage, nil, nil, nil)
        
        
        // we choose unlit so that the glow is not affected by light 
        var material = UnlitMaterial()
        
        do {
            // Create texture with transparency
            let textureResource = try TextureResource.generate(
                from: cgImage,
                options: .init(semantic: .color)
            )
            
            material.color.texture = MaterialParameters.Texture(textureResource)
            material.color.texture?.sampler.modify({ samplingDesc in
                samplingDesc.rAddressMode = .clampToEdge
                samplingDesc.sAddressMode = .clampToEdge
                samplingDesc.tAddressMode = .clampToEdge
                samplingDesc.mipFilter = .notMipmapped
            })
            
            material.blending = .transparent(opacity: 0.99)
        } catch {  
            print("fail loading texture")
        }
        return material 
    }
}
