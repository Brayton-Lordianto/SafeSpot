import SwiftUI
import RealityKit
import ARKit
import RoomPlan

// This is where we create new meshes and add them to the arview anchor 
extension HazardRoomScanDelegate {
    // NOTE: there was a lot of need to wrap in task main actor to get things working. 
    
    func createNewObjectMesh(_ obj: CapturedRoom.Object) { 
        let position = obj.transform
        let dimensions = obj.dimensions
        let classificiation = obj.category
        let safetyCategory = currentHazard.categorizeObject(classificiation)
        let safetyText = currentHazard.getGuidanceText(for: classificiation)
        guard safetyCategory != .none else { return }
        objectsToMesh[obj.identifier] = ObjectMesh(position, dimensions, classificiation.displayName, safetyCategory, safetyText)
        
        // add to ar view 
        Task { @MainActor in 
            if let meshes = objectsToMesh[obj.identifier] {
                mainAnchor.addChild(meshes.bboxEntity)
                mainAnchor.addChild(meshes.textEntity)
            } 
        }
    }

    func createNewObjectMesh(_ obj: CapturedRoom.Surface) { 
        let position = obj.transform
        let dimensions = obj.dimensions
        let classificiation = obj.category
        let safetyCategory = currentHazard.categorizeSurface(classificiation)
        let safetyText = currentHazard.getGuidanceText(for: classificiation)
        guard safetyCategory != .none else { return }       
        objectsToMesh[obj.identifier] = ObjectMesh(position, dimensions, classificiation.displayName, safetyCategory, safetyText)
        
        // add to ar view 
        Task { @MainActor in 
            if let meshes = objectsToMesh[obj.identifier] {
                mainAnchor.addChild(meshes.bboxEntity)
                mainAnchor.addChild(meshes.textEntity)
            }
        }
    }        

    // I tried doing this every frame but it just messed things up. better to use this to just set the zoom as it gets further or something
    func updateMeshtransforms(_ obj: CapturedRoom.Object) { 
        Task { @MainActor in
            guard let meshes = objectsToMesh[obj.identifier] else { return }
            meshes.bboxEntity.transform = .init(matrix: obj.transform)
            
            meshes.textEntity.transform = .init(matrix: obj.transform)
            meshes.textEntity.transform.translation.z -= obj.dimensions.z / 2
        }
    }
    
    func updateMeshtransforms(_ obj: CapturedRoom.Surface) { 
        Task { @MainActor in
            guard let meshes = objectsToMesh[obj.identifier] else { return }
            meshes.bboxEntity.transform = .init(matrix: obj.transform)
            
            meshes.textEntity.transform = .init(matrix: obj.transform)
//            meshes.textEntity.transform.translation.y += obj.dimensions.y / 4 
            meshes.textEntity.transform.translation.z -= obj.dimensions.z / 2  
        }
    }
}
