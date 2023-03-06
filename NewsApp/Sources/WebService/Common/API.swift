import Foundation

enum API {
    case source
    case headline(String)
    case category(String)
    
    var parameters: [String: String] {
        switch self {
        case .source:
            return [:]
        case .headline(let id):
            return ["sources": id]
        case .category(let category):
            return ["category": category]
        }
    }
    
    var path: String {
        switch self {
        case .source:
            return "/v2/top-headlines/sources"
        case .headline:
            return "/v2/top-headlines"
        case .category:
            return "/v2/top-headlines/sources"
        }
    }
}

