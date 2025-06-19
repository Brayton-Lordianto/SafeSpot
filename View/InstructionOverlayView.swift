import SwiftUI

struct InstructionOverlay: View {
    let text: String
    
    var body: some View {
        VStack {
            Spacer() // Pushes content to bottom
            
            Overlay(text: text)
        }
    }
}

struct Overlay: View { 
    let text: String 
    var body: some View { 
        Text(text)
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.vertical, 16)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.green.opacity(0.9))
                    .shadow(color: .black.opacity(0.2), radius: 10)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 30) // Safe area padding
    }
}
