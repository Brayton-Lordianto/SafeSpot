import RoomPlan

extension RoomCaptureSession.Instruction {
    var text: String {
        switch self {
        case .normal:
            return "Stay Safe!"
        case .moveCloseToWall:
            return "Move closer to the wall"
        case .moveAwayFromWall:
            return "Step back from the wall"
        case .turnOnLight:
            return "Please turn on more lights"
        case .slowDown:
            return "Move the device more slowly"
        case .lowTexture:
            return "Point at areas with more visible features"
        @unknown default:
            return "Continue scanning the room (unknown instruction)"
        }
    }
}
