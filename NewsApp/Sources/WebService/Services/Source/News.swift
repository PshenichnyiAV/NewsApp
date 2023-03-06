
import Foundation

// MARK: - News
struct News: Codable {
    let status: String
    let sources: [Source]
}

// MARK: - Source
struct Source: Codable {
    let id, name, sourceDescription: String
    let url: String
    let category: SourceCategory
    let country: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case sourceDescription = "description"
        case url, category, country
    }
}

enum Language: String, Codable {
    case en = "en"
}
