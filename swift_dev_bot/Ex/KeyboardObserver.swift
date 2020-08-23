import UIKit
import SwiftUI

final class KeyboardObserver: ObservableObject {
    
    // MARK: Static properties
    static let shared = KeyboardObserver()
    
    // MARK: Stored properties
    @Published
    private(set) var rect: CGRect = .zero
    
    // MARK: Computed properties
    var height: CGFloat { rect.height }
    
    // MARK: Init
    private init() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.rect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] (notification) in
            self?.rect = .zero
        }
    }
}
