import Foundation

struct GithubMessage: Identifiable {
    internal init(message: String) {
        self.message = message
    }
    
    let id: String = UUID().uuidString
    let message: String
}
