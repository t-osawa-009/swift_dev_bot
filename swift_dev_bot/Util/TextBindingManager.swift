import Foundation

final class TextBindingManager: ObservableObject {
    @Published var text = "" {
        didSet {
            didChangeText?(text)
        }
    }
    
    var didChangeText: ((String) -> Void)?
}

