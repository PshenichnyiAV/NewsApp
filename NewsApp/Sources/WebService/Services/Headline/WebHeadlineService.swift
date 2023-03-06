import Foundation

protocol HeadlineService {
    func load(id: String,completion: @escaping (Result<Headline, Error>) -> ())
}

final class WebHeadlineService: HeadlineService {
    let service: WebService
    init(service: WebService) {
        self.service = service
    }
    
    func load(id: String, completion: @escaping (Result<Headline, Error>) -> ()) {
        service.fetchData(api: .headline(id), completion: completion)
    }
}

