import SwiftUI
import RealityKit

// This is self cleaning using state. Whenever it is not active (when user goes to back page), we remove everything. 
struct HazardScannerView: View {
    let hazard: HazardType
    @Binding var isActive: Bool
    @State var scannerState: ScannerState? = nil 
    @Environment(\.dismiss) private var dismiss
    @StateObject private var instructionState = InstructionState.shared
    
    var body: some View {
        VStack {
            ZStack {
                if scannerState != nil {
                    ZStack {
                        HazardScannerViewRepresentable(
                            scanner: scannerState!.scanner
                        )
                        .edgesIgnoringSafeArea(.all)
                        .overlay(controlsOverlay)
                        .navigationBarBackButtonHidden(true)
                        
                        if let _ = instructionState.instructionText { 
                            InstructionOverlay(text: instructionState.instructionText ?? "")
                        }
                    }
                } else {
                    Color(.systemBackground) // Placeholder when inactive
                }
                
                VStack { 
                    Overlay(text: hazard.rawValue)
                        .scaleEffect(0.5)
                    Spacer()
                }
            }
        }
        .onAppear {
            scannerState = .init(hazard)
            scannerState?.setupScanner()
        }
        .onDisappear {
            scannerState?.cleanup()
            self.scannerState = nil 
        }
    }
    
    private var controlsOverlay: some View {
        VStack {
            HStack {
                Button(action: {
                    isActive = false
                    dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                }
                Spacer()
            }
            Spacer()
        }
    }
}

struct HazardScannerViewRepresentable: UIViewRepresentable {
    // Hold reference to your scanner class
    var scanner: HazardRoomScanDelegate
    
    func makeUIView(context: Context) -> ARView {
        return scanner.arView ?? ARView(frame: .zero)    
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Updates happen through the delegate callbacks, 
        // so we don't need to do anything here
    }
}
