import SwiftUI
import RoomPlan

extension HazardType { 
    func getGuidanceText(for category: CapturedRoom.Object.Category) -> String {
        switch self {
        case .earthquake:
            switch category {
            case .table:
                return "GET\nUNDER"
            case .bed, .sofa:
                return "COVER\nHEAD"
            case .storage:
                return "STAY\nAWAY\nItems may fall"
            case .television:
                return "DANGER\nMay fall"
            default:
                return "CAUTION"
            }
            
        case .fire:
            switch category {
            case .stairs:
                return "EXIT\nDOWN\nStay low"
            case .stove, .fireplace, .oven:
                return "FIRE\nRISK\nStay back"
            case .storage:
                return "GRAB\nKIT"
            default:
                return "CAUTION"
            }
            
        case .flood:
            switch category {
            case .stairs:
                return "GO\nUP\nAvoid ground floor"
            case .storage:
                return "GRAB\nSUPPLIES"
            case .washerDryer:
                return "DANGER\nElectrical hazard"
            default:
                return "CAUTION"
            }
            
        case .tornado:
            switch category {
            case .stairs:
                return "GO\nDOWN\nSeek basement"
            case .storage:
                return "SHELTER\nHERE\nIf no windows"
            default:
                return "SEEK\nSHELTER"
            }
        }
    }
    
    func getGuidanceText(for category: CapturedRoom.Surface.Category) -> String {
        switch self {
        case .earthquake:
            switch category {
            case .door:
                return "NOT\nSAFE\nFind better cover"
            case .window:
                return "DANGER\nStay away"
            default:
                return "CAUTION"
            }
        case .fire:
            switch category {
            case .door:
                return "EXIT\nCheck Heat First"
            case .window:
                return "BACKUP\nEXIT"
            default:
                return "CAUTION"
            }
        case .flood:
            switch category {
            case .door:
                return "SEAL\nBlock water"
            case .window:
                return "WATCH\nWater level"
            case .opening:
                return "BLOCK\nWater flow"
            default:
                return "MONITOR"
            }
        case .tornado:
            switch category {
            case .window:
                return "DANGER\nStay away"
            case .opening:
                return "SECURE\nClose all"
            case .door:
                return "SECURE\nLock & brace"
            default:
                return "CAUTION"
            }
        }
    }
}
