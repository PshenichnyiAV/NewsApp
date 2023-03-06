import Foundation

protocol SourceService {
    func load(completion: @escaping (Result<News, Error>) -> ())
    func load() async throws -> News
}

final class WebSourceService: SourceService {
    let service: WebService
    init(service: WebService) {
        self.service = service
    }
    
    func load(completion: @escaping (Result<News, Error>) -> ()) {
        service.fetchData(api: .source, completion: completion)
    }
    
    func load() async throws -> News {
       try await service.fetchData(api: .source)
    }
}
