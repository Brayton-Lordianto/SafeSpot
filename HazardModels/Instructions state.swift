import SwiftUI

// a singleton holding global instructions
class InstructionState: ObservableObject {
    static let shared = InstructionState()
    
    @Published var instructionText: String? = nil 
    private init() {} // Singleton
}
