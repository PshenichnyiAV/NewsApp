import Foundation

final class HeadlineViewModel {
    
    //MARK: - var
    
    private(set) var article = [Article]()   // в этом файле работаем добавляем и тд, а в дургих ток берем
    
    //MARK: - let
    
    private let headlineService: HeadlineService
    private let id: String
    
    //MARK: - init
    
    init(id: String, headline: HeadlineService) {
        self.headlineService = headline
        self.id = id
    }
    
    //MARK: - Flow function
    
    func load(completion: @escaping (Error?) -> ()) {
        headlineService.load(id: id) { [weak self] result in
            switch result {
            case .success(let headlineNews):
                self?.article = headlineNews.articles
                completion(nil)
                print(headlineNews)
            case .failure(let error):
                print(error.localizedDescription)
                completion(error)
            }
        }
    }
    
}
