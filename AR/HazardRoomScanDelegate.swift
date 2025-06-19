import SwiftUI
import UIKit
import RoomPlan
import ARKit
import RealityKit

// if true, results are a bit more janky but it seems more robust to movement
let UPDATE_TRANSFORM_EVERY_FRAME = false 

// MARK: a container of our main camera view. Being a RoomCaptureSessionDelegate, it has callbacks that provide the Room information every frame. We then render custom UI on our ARView.  
class HazardRoomScanDelegate: RoomCaptureSessionDelegate { 
    var arView: ARView!
    let captureSession = RoomCaptureSession() 
    var objectsToMesh = [UUID:ObjectMesh]()
    var currentObjects: Set<UUID> = .init()
    var mainAnchor = AnchorEntity()
    var currentHazard: HazardType    
    
    init(hazardType: HazardType = .earthquake) {
        currentHazard = hazardType
        captureSession.delegate = self 
        arView = ARView() 
        arView.session = captureSession.arSession
        arView.scene.anchors.append(mainAnchor) 
    }
    
    func captureSession(_ session: RoomCaptureSession, didProvide instruction: RoomCaptureSession.Instruction) {
        print(instruction.text)
        if instruction == .normal { InstructionState.shared.instructionText = nil }
        else { InstructionState.shared.instructionText = instruction.text }
    }
    
    func captureSession(_ session: RoomCaptureSession, didUpdate room: CapturedRoom) {
        for obj in room.objects {
            let id = obj.identifier
            if !currentObjects.contains(id) {
                currentObjects.insert(id)
                self.createNewObjectMesh(obj)     
                print("added to object mesh")
                self.updateMeshtransforms(obj)                
            } 
            
            if UPDATE_TRANSFORM_EVERY_FRAME {
                self.updateMeshtransforms(obj)
            }
        } 
        
        for obj in room.doors + room.windows + room.walls {
            let id = obj.identifier
            if !currentObjects.contains(id) {
                currentObjects.insert(id)
                self.createNewObjectMesh(obj)
                print("added to object mesh")
                self.updateMeshtransforms(obj)                
            } 
            
            if UPDATE_TRANSFORM_EVERY_FRAME {
                self.updateMeshtransforms(obj)
            }
        }
    }
    
    func cleanup() {
        // Clear all meshes and resources
        for (_, mesh) in objectsToMesh {
            mesh.bboxEntity.removeFromParent()
            mesh.textEntity.removeFromParent()
        }
        objectsToMesh.removeAll()
        currentObjects.removeAll()
        mainAnchor.removeFromParent()
        arView = nil
    }
} 
