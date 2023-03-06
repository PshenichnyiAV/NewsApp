import Foundation

final class SourceViewModel {
    
    //MARK: - var
    
    private(set) var news = [Source]()
    
    //MARK: - let
    
    private let sourceService: SourceService
    private let categoriesService: CategoriesService
    
    //MARK: - init
    
    init(sourceService: SourceService, categoriesService: CategoriesService) {
        self.sourceService = sourceService
        self.categoriesService = categoriesService
    }
    
    //MARK: - Flow function
    
    func load(completion: @escaping (Error?) -> ()) {
        sourceService.load { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news.sources
                completion(nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    @MainActor func asyncLoad(completion: @escaping (Error?) -> ()) {
        Task {
            do {
                let news = try await sourceService.load()
                self.news = news.sources
                completion(nil)
            } catch {
                print(error.localizedDescription)
                completion(error)
            }
        }
    }
    
    func loadCategory(category: SourceCategory, completion: @escaping (Error?) -> ()) {
        categoriesService.load(category: category) { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news.sources
                completion(nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(error)
            }
        }
    }
    
}
