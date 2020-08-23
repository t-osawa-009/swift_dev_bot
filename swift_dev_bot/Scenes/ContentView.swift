import SwiftUI

struct ContentView: View {
    @EnvironmentObject
    private var store: Store<AppState, ActionType>
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: GithubMessageView()) {
                    Text("Commit message")
                }
            }
            .navigationBarTitle("Menu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
