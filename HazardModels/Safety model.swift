import SwiftUI

enum SafetyCategory {
    case primary    // Green - Safest spots
    case secondary  // Yellow - Secondary safe areas
    case danger     // Red - Danger zones
    case resource   // Blue - Resources/Equipment
    case none 
    
    var color: Color {
        switch self {
        case .primary: return .green
        case .secondary: return .yellow
        case .danger: return .red
        case .resource: return .blue
        case .none: return .clear
        }
    }
        
    var displayText: String? {
        switch self {
        case .primary: return "SAFE ZONE"
        case .secondary: return nil
        case .danger: return "DANGER"
        case .resource: return "SUPPLIES"
        case .none: return nil 
        }
    }
}
