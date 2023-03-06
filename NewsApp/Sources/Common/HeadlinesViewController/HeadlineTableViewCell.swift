import UIKit
import AlamofireImage

class HeadlineTableViewCell: UITableViewCell {
    
    //MARK: - let
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        return containerView
    }()
    
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
    
    private let sourceDescriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.backgroundColor =  .clear
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var article: Article? {
        didSet {
            setData()
            loadImage()
        }
    }
    
    //MARK: - init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setupConstraints()
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        sourceDescriptionLabel.text = nil
        image.image = nil
    }
    
    //MARK: - Flow function
    
    private func setupConstraints() {
        
        contentView.addSubview(containerView)
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
        containerView.addSubview(image)
        image.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1/1.5).isActive = true
        
        containerView.addSubview(titleLabel)
        titleLabel.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant: -5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 10).isActive = true
        
        containerView.addSubview(sourceDescriptionLabel)
        sourceDescriptionLabel.topAnchor.constraint(equalTo:titleLabel.bottomAnchor, constant: 10).isActive = true
        sourceDescriptionLabel.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant: 5).isActive = true
        sourceDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true
        sourceDescriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: containerView.bottomAnchor, constant: -5).isActive = true
    }
    
    private func setData() {
        guard let article = article else { return }
        titleLabel.text = article.title
        sourceDescriptionLabel.text = article.articleDescription
    }
    
    private func loadImage() {
        guard let newsImage = article?.urlToImage else {
            image.image = UIImage(named: "IMG")
            return }
        guard let url = URL(string: newsImage) else { return }
        image.af.setImage(withURL: url, imageTransition: .crossDissolve(0.2))
    }
    
    private func configureUI() {
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.2
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
    }
}

