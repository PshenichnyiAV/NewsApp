import UIKit
import AlamofireImage

class DetailNewsViewController: UIViewController {
    
    //MARK: - let
    
    private let viewModel: DetailNewsViewModel
    
    private let image:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sourceDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let linkTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    //MARK: - Lifecycle function
    
    init(viewModel: DetailNewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        loadImage()
        setData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupConstraints()
    }
    
    //MARK: - Flow function
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        titleLabel.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        view.addSubview(image)
        image.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1/1.5).isActive = true
        
        view.addSubview(sourceDescriptionLabel)
        sourceDescriptionLabel.topAnchor.constraint(equalTo:image.bottomAnchor, constant: 10).isActive = true
        sourceDescriptionLabel.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20).isActive = true
        sourceDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        view.addSubview(linkTextView)
        linkTextView.topAnchor.constraint(equalTo:sourceDescriptionLabel.bottomAnchor, constant: 10).isActive = true
        linkTextView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 20).isActive = true
        linkTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
    }
    
    private func setData() {
        titleLabel.text = viewModel.article.title
        sourceDescriptionLabel.text = viewModel.article.content
        linkTextView.attributedText = viewModel.article.url.link()
    }
    
    private func loadImage() {
        guard let newsImage = viewModel.article.urlToImage else {
            image.image = UIImage(named: "IMG")
            return
        }
        guard let url = URL(string: newsImage) else { return }
        image.af.setImage(withURL: url, imageTransition: .crossDissolve(0.2))
    }
    
    private func configure(){
        title = "Detail info"
        view.backgroundColor = .systemBackground
        linkTextView.delegate = self
    }
}
extension DetailNewsViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
