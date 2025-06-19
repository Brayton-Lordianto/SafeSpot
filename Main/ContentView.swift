import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack { 
            MainTabView()
        }
        .onAppear(perform: {
            let _ = ObjectMeshGlobals.shared // initialize so it is easier for later on when you access it 
        })
    }
}
 
