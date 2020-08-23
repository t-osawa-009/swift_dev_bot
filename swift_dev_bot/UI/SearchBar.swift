import Foundation
import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct SearchBarView: View {
    internal init(text: String, onCommit: @escaping () -> Void = {print("onCommit")}, didChangeText: @escaping ((String) -> Void)) {
        self.textBindingManager.text = text
        self.onCommit = onCommit
        self.textBindingManager.didChangeText = didChangeText
    }
    
    @ObservedObject
    private var textBindingManager = TextBindingManager()
    @State
    private var showCancelButton: Bool = false
    
    var onCommit: () -> Void = {print("onCommit")}
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                // Search text field
                ZStack (alignment: .leading) {
                    if textBindingManager.text.isEmpty { // Separate text for placeholder to give it the proper color
                        Text("Search")
                    }
                    TextField("", text: $textBindingManager.text, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: onCommit).foregroundColor(.primary)
                }
                // Clear button
                Button(action: {
                    self.textBindingManager.text = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(textBindingManager.text == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary) // For magnifying glass and placeholder test
            .background(Color(.tertiarySystemFill))
            .cornerRadius(10.0)
            
            if showCancelButton  {
                // Cancel button
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.textBindingManager.text = ""
                    self.showCancelButton = false
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
        .navigationBarHidden(showCancelButton)
    }
}
