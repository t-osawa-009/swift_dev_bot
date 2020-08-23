import Foundation

struct GithubMessageState {
    var githubMessages: [GithubMessage] = []
    fileprivate static let array = PlistParser.parseCommitMessage()
}

extension GithubMessageState {
    static func reducer(action: ActionType, state: GithubMessageState) -> GithubMessageState {
        guard let action = action as? GithubMessageAction else { return state }
        var state = state
        switch action {
        case .search(let text):
            if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                state.githubMessages = GithubMessageState.array.map({ GithubMessage(message: $0) })
            } else {
                let array = GithubMessageState.array.lazy.filter({ $0.lowercased().contains(text.lowercased())})
                state.githubMessages = array.map({ GithubMessage(message: $0) })
            }
        }
        return state
    }
}
