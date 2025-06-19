import SwiftUI
struct HazardLibrary: View {
    @State private var selectedHazard: HazardType?
    @State private var isARViewActive = false
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                // Calculate the number of columns based on screen width
                let columns = [
                    GridItem(.adaptive(minimum: geometry.size.width / 3, maximum: 300), spacing: 16)
                ]
                
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach([HazardType.earthquake, .fire, .flood, .tornado]) { hazard in
                        NavigationLink {
                            HazardScannerView(
                                hazard: hazard,
                                isActive: $isARViewActive
                            )
                        } label: {
                            HazardCard(
                                title: hazard.rawValue.capitalized,
                                icon: hazard.icon,
                                color: hazard.color
                            )
                            .frame(height: 300) // Maintain aspect ratio
                        }
                    }
                }
                .padding(16)
            }
        }
    }
}
