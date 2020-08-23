import Foundation

public protocol ActionType { }

enum AppAction: ActionType {
    
}

enum GithubMessageAction: ActionType {
    case search(String)
}

enum GitCommandAction: ActionType {
    case search(String)
}
