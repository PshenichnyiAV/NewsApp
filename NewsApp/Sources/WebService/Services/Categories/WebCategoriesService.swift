import Foundation

protocol CategoriesService {
    func load(category: SourceCategory,completion: @escaping (Result<News, Error>) -> ())
}

final class WebCategoriesService: CategoriesService {
    let service: WebService
    init(service: WebService) {
        self.service = service
    }
    
    func load(category: SourceCategory, completion: @escaping (Result<News, Error>) -> ()) {
        service.fetchData(api: .category(category.rawValue), completion: completion)
    }
}
