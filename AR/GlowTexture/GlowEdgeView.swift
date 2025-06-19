import SwiftUI

// The view that will be used as our texture
struct GlowEdgeView: View {
    let color: Color // Slightly transparent for better blend
    public init(color: Color) { self.color = color }
    
    var body: some View {
        ZStack {
            // Clear background
            Rectangle() 
                .fill(.clear)
                .ignoresSafeArea()
                .frame(width: 512 / 2, height: 512 / 2)
                .background {
                    ZStack {
                        if color == .red {
                            Text("🛑")
                                .rotationEffect(.init(degrees: .init(180)))
                        }
//                        if color == .green { 
//                            Text("🛡️")
//                                .rotationEffect(.init(degrees: .init(180)))
//                        }
                        InnerView
                    }
                }
        }
        .preferredColorScheme(.light)
    }
    
    var InnerView: some View { 
        nonShadedRectangle
            .shadow(color: color, radius: 2, x: 0, y: 0)
            .shadow(color: color, radius: 4, x: 0, y: 0)
            .shadow(color: color, radius: 8, x: 0, y: 0)
            .shadow(color: color, radius: 16, x: 0, y: 0)
            .shadow(color: color, radius: 32, x: 0, y: 0)
            .shadow(color: color, radius: 64, x: 0, y: 0)
        // Add more intense inner glow
            .blur(radius: 0.2)
    }
    
    var nonShadedRectangle: some View { 
        Rectangle()
            .strokeBorder(color, lineWidth: 1.5)  // Thicker base stroke
    }
}
