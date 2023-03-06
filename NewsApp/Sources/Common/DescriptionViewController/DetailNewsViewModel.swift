import Foundation

final class DetailNewsViewModel {
    
    //MARK: - var
    
    private(set) var article: Article
    
    //MARK: - init
    
    init(article: Article) {
        self.article = article
    }
}
