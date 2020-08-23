import SwiftUI
import SwiftUIKit

struct GithubMessageView: View {
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
                self.store.send(GithubMessageAction.search(self.newMessage))
            }) { (text) in
                self.newMessage = text
                self.store.send(GithubMessageAction.search(text))
            }
            
            List(store.state.githubMessageState.githubMessages) { item in
                Text(item.message).onTapGesture {
                    PasteboardWrapper.default.copy(item.message)
                    self.isToastPresented.toggle()
                }
            }
        }
        .toast(isPresented: $isToastPresented,
               text: "Copy done",
               background: Color.primary.colorInvert(),
               duration: TimeInterval(0.8))
    }
}

struct GithubMessageView_Previews: PreviewProvider {
    static var previews: some View {
        GithubMessageView()
    }
}
