import Foundation

enum PlistParser {
    static func parseConfig() -> [String] {
        let url = Bundle.main.url(forResource: "CommitMessage", withExtension: "plist")!
        let data = try! Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        return try! decoder.decode([String].self, from: data)
    }
}
