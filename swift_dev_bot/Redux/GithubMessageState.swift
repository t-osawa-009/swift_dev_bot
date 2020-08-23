import Foundation

struct GithubMessageState {
    var githubMessages: [GithubMessage] = []
    fileprivate static let array = PlistParser.parseConfig()
}

extension GithubMessageState {
    static func reducer(action: ActionType, state: GithubMessageState) -> GithubMessageState {
        guard let action = action as? GithubMessageAction else { return state }
        var state = state
        switch action {
        case .search(let text):
            let array = GithubMessageState.array.filter({ $0.lowercased().contains(text.lowercased())})
            state.githubMessages = array.map({ GithubMessage(message: $0) })
        }
        return state
    }
}
