import Foundation

// MARK: - Headline
struct Headline: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: SourceHeadline
    let author: String?
    let title, articleDescription: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK: - Source
struct SourceHeadline: Codable {
    let id: String?
    let name: String
}
