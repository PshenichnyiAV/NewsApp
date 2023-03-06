import Foundation

protocol WebService {
    func fetchData<T: Codable>(api: API, completion: @escaping (Result<T, Error>) -> ())
    func fetchData<T: Codable>(api: API) async throws -> T
}

final class CommonWebService: WebService {
    func fetchData<T: Codable>(api: API, completion: @escaping (Result<T, Error>) -> ()) {
        guard let url = makeUrl(api: api) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            } else {
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(result))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchData<T: Codable>(api: API) async throws -> T {
        guard let url = makeUrl(api: api) else { throw URLError(.badURL) }
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(T.self, from: data)
        return result
    }
    
    private func makeUrl(api: API) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = api.path
        components.queryItems = api.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems?.append(URLQueryItem(name: "apiKey", value: ApiKeys.newsKey))
        return components.url
    }
}
