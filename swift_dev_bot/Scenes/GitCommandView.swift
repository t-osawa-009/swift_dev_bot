import SwiftUI

struct GitCommandView: View {
    @EnvironmentObject
    private var store: Store<AppState, ActionType>
    @EnvironmentObject
    private var keyboardObserver: KeyboardObserver
    @State
    private var newMessage = ""
    @State
    private var isToastPresented = false
    
    var body: some View {
        VStack {
            SearchBarView(text: newMessage, onCommit: {
                self.store.send(GitCommandAction.search(self.newMessage))
            }) { (text) in
                self.newMessage = text
                self.store.send(GitCommandAction.search(text))
            }
            
            List(store.state.gitCommandState.githubMessages) { item in
                Text(item.message).onTapGesture {
                    PasteboardWrapper.default.copy(item.message)
                    self.isToastPresented.toggle()
                }
            }
        }
        .onAppear(perform: {
            self.store.send(GitCommandAction.search(self.newMessage))
        })
            .toast(isPresented: $isToastPresented,
                   text: "Copy done",
                   background: Color.primary.colorInvert(),
                   duration: TimeInterval(0.8))
    }
}

struct GitCommandView_Previews: PreviewProvider {
    static var previews: some View {
        GitCommandView()
    }
}
