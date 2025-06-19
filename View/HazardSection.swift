import SwiftUI

// MARK: - Hazard Section
struct HazardSection: View {
    let hazard: HazardType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Image(systemName: hazard.icon)
                    .font(.title)
                    .foregroundColor(hazard.color)
                
                Text(hazard.rawValue.capitalized)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
            
            // Hazard Overview
            Text(hazard.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                // Safe/Unsafe Zones Diagram
                HazardDiagram(hazard: hazard)
                
                // Summary of Section 
                HazardSummarySection(hazard: hazard)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct HazardDiagram: View {
    let hazard: HazardType
    var images: [String] {
        switch hazard {
        case .earthquake:
            return ["Image Asset 5", "Image Asset 4"]
        case .fire:
            return ["Image Asset 3", "Image Asset 2"]
        case .flood:
            return ["Image Asset 1"]
        case .tornado:
            return ["Image Asset"]
        }
    }
    
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Safe & Unsafe Zones")
                .font(.headline)
                .foregroundColor(.primary)
            
            // Swipeable Image Gallery
            TabView(selection: $currentIndex) {
                ForEach(0..<images.count, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide default page indicator
            .frame(height: 400)
            
            // Custom Page Indicator
            HStack {
                ForEach(0..<images.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? hazard.color : Color.gray.opacity(0.5))
                        .frame(width: 8, height: 8)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 8)
        }
    }
}

struct HazardSummarySection: View {
    let hazard: HazardType
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            Text("Quick Summary for \(hazard.rawValue.capitalized)")
                .font(.headline)
                .foregroundColor(.primary)
            
            // Things to Avoid
            VStack(alignment: .leading, spacing: 8) {
                Text("Things to Avoid")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                
                ForEach(hazard.thingsToAvoid, id: \.self) { item in
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                        Text(item)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            // Things That Are Good
            VStack(alignment: .leading, spacing: 8) {
                Text("Things That Are Good")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
                
                ForEach(hazard.thingsThatAreGood, id: \.self) { item in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)
                        Text(item)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
