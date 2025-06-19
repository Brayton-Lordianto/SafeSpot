import SwiftUI
import RoomPlan

// I ended up not using these texts. but they can be helpful if ever needed. I chose other guidance texts for the user. 
extension CapturedRoom.Object.Category {
    var displayName: String {
        switch self {
        case .bathtub: return "Bathtub"
        case .bed: return "Bed"
        case .chair: return "Chair"
        case .dishwasher: return "Dishwasher"
        case .fireplace: return "Fireplace"
        case .oven: return "Oven"
        case .refrigerator: return "Refrigerator"
        case .sink: return "Sink"
        case .sofa: return "Sofa"
        case .stairs: return "Stairs"
        case .storage: return "Storage"
        case .stove: return "Stove"
        case .table: return "Table"
        case .television: return "Television"
        case .toilet: return "Toilet"
        case .washerDryer: return "Washer/Dryer"
        @unknown default: return "Unknown Object"
        }
    }
}

extension CapturedRoom.Surface.Category {
    var displayName: String {
        switch self {
        case .floor: return "Floor"
        case .door(let isOpen): return "Door (\(isOpen ? "Open" : "Closed"))"
        case .opening: return "Opening"
        case .wall: return "Wall"
        case .window: return "Window"
        @unknown default: return "Unknown Surface"
        }
    }
}
