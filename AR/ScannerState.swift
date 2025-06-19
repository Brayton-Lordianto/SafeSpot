import SwiftUI

// holds the state of the scanning in the app. used to clear objects as an optimization. 
class ScannerState: ObservableObject {
    private(set) var scanner: HazardRoomScanDelegate
    
    public init(_ hazard: HazardType) {
        scanner = HazardRoomScanDelegate(hazardType: hazard)
    }
    
    func setupScanner() {
        scanner.captureSession.run(configuration: .init())
    }
    
    func cleanup() {
        scanner.captureSession.stop()
        scanner.cleanup()
    }
}
