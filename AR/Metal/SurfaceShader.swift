import SwiftUI
import Metal
import RealityKit

// MARK: this was abandoned. Does not work because swift playground doesn't support realitykit header files for metal. Poor metal support in general. 
class MaterialLibrary {
    static let shared = MaterialLibrary()
    private let device: MTLDevice
    private var metalLibrary: MTLLibrary?
    
    // Cache materials we create
    private var materialCache: [String: CustomMaterial] = [:]
    
    private init() {
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Failed to create MTL device")
        }
        self.device = device
        setupLibrary()
    }
    
    private func setupLibrary() {
        let shaderSource = """
        #include <metal_stdlib>
        using namespace metal;
        
        [[visible]]
        float4 yellowShader(float2 uv)
        {
            discard_fragment();
            return float4(1.0,0.0,0.0,1.0);
        }
                
        // Add more shaders here as needed...
        """
        
        do {
            metalLibrary = try device.makeLibrary(source: shaderSource, options: nil)
        } catch {
            print("Failed to create metal library: \(error)")
        }
    }
    
    enum MaterialType {
        case yellow
        case red
        // Add more types as needed
        
        var shaderName: String {
            switch self {
            case .yellow: return "yellowShader"
            case .red: return "redShader"
            }
        }
    }
    
    func getMaterial(_ type: MaterialType) -> CustomMaterial? {
        // Check cache first
        if let cachedMaterial = materialCache[type.shaderName] {
            return cachedMaterial
        }
        
        guard let library = metalLibrary else {
            print("Metal library not initialized")
            return nil
        }
        
        do {
            let surfaceShader = CustomMaterial.SurfaceShader(
                named: type.shaderName,
                in: library
            )
            
            let material = try CustomMaterial(
                surfaceShader: surfaceShader,
                geometryModifier: nil,
                lightingModel: .lit
            )
            
            // Cache the created material
            materialCache[type.shaderName] = material
            
            return material
        } catch {
            print("Failed to create material: \(error)")
            return nil
        }
    }
    
    // Helper to clear cache if needed
    func clearCache() {
        materialCache.removeAll()
    }
}
