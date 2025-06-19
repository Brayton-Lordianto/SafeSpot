import SwiftUI
import RoomPlan

enum HazardType: String, Identifiable {
    case earthquake
    case fire
    case flood
    case tornado
    
    var id: String { self.rawValue }
    
    var icon: String {
        switch self {
        case .earthquake: return "waveform.path.ecg"
        case .fire: return "flame.fill"
        case .flood: return "water.waves"
        case .tornado: return "tornado"
        }
    }
    
    var color: Color {
        switch self {
        case .earthquake: return .orange
        case .fire: return .red
        case .flood: return .blue
        case .tornado: return .purple
        }
    }
    
    func categorizeObject(_ category: CapturedRoom.Object.Category) -> SafetyCategory {
        switch self {
        case .earthquake:
            switch category {
            case .table: return .primary
            case .bed, .sofa: return .secondary
            case .television, .storage: return .danger
            default: return .none
            }
            
        case .fire:
            switch category {
            case .stove, .fireplace, .oven: return .danger
            case .storage: return .resource
            default: return .none
            }
            
        case .flood:
            switch category {
            case .stairs: return .primary
            case .storage: return .resource
            case .washerDryer, .television: return .danger
            default: return .none
            }
            
        case .tornado:
            switch category {
            case .stairs: return .primary
            case .storage: return .resource
            default: return .none
            }
        }
    }
    
    func categorizeSurface(_ category: CapturedRoom.Surface.Category) -> SafetyCategory {
        switch self {
        case .earthquake:
            switch category {
            case .door: return .secondary
            case .window: return .danger
            default: return .none
            }
            
        case .fire:
            switch category {
            case .door: return .primary
            case .window: return .secondary
            default: return .none
            }
            
        case .flood:
            switch category {
            case .window: return .danger
            case .door: return .danger
            default: return .none
            }
            
        case .tornado:
            switch category {
            case .window: return .danger
            default: return .none
            }
        }
    }
}
