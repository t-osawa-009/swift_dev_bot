import Foundation

extension Reducer where State == AppState, Action == ActionType {
    static func appReducer() -> Reducer {
        return Reducer { state, action in
            return Reducer.sync { state in
                state.githubMessageState = GithubMessageState.reducer(action: action, state: state.githubMessageState)
            }
        }
    }
}
