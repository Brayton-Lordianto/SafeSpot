import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Welcome Section
                    WelcomeSection()
                    
                    // Hazard Sections
                    ForEach([HazardType.earthquake, .fire, .flood, .tornado]) { hazard in
                        HazardSection(hazard: hazard)
                    }
                }
                .padding()
            }
            .navigationTitle("Learn & Prepare")
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

struct WelcomeSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome to SafeSpot")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("SafeSpot is an offline disaster preparedness app that uses augmented reality (AR) to guide users to safety during earthquakes, fires, floods, and tornados—even without prior knowledge of hazards. By looking at your surroundings in real-time, the app identifies safe zones (like sturdy tables or interior rooms) EVEN FROM AFAR and warns about dangers (like windows or heavy furniture) using intuitive color coding and clear instructions. Designed for high-stress situations, SafeSpot works without internet connectivity, making it ideal for areas with limited access. Whether you're at home, work, or in an unfamiliar place, SafeSpot empowers you to make quick, informed decisions that could save lives. It’s like having a safety expert in your pocket, ready to help when disaster strikes.\n\nInstructions: Move your camera around to begin and look out for bounding boxes and text instructions that show up.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
