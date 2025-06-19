import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack(content: {
                Text("What's Your Emergency?")
                    .font(.largeTitle)
                    .padding(.top)
                    .bold()
                Text("Select Hazard")
                    .font(.subheadline)
                HazardLibrary()
            })
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
                .tabItem {
                    Label("Scan", systemImage: "camera.viewfinder")
                }
                .tag(0)
            
            HomeView()
                .tabItem {
                    Label("Learn", systemImage: "book.fill")
                }
                .tag(1)
        }
    }
}
