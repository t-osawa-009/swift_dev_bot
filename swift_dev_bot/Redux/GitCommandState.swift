import Foundation

struct GitCommandState {
    var githubMessages: [GithubMessage] = []
    fileprivate static let array = PlistParser.parseGitCommand()
}

extension GitCommandState {
    static func reducer(action: ActionType, state: GitCommandState) -> GitCommandState {
        guard let action = action as? GitCommandAction else { return state }
        var state = state
        switch action {
        case .search(let text):
            if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                state.githubMessages = GitCommandState.array.map({ GithubMessage(message: $0) })
            } else {
                let array = GitCommandState.array.lazy.filter({ $0.lowercased().contains(text.lowercased())})
                state.githubMessages = array.map({ GithubMessage(message: $0) })
            }
        }
        return state
    }
}
