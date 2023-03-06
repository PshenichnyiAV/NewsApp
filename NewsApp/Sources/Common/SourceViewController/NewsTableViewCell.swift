import UIKit

class NewsTableViewCell: UITableViewCell {
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  .black
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
    
    var news: Source? {
        didSet {
            setData()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        sourceDescriptionLabel.text = nil
    }
    
    private func setupConstraints() {
        contentView.addSubview(nameLabel)
        nameLabel.trailingAnchor.constraint(equalTo:contentView.trailingAnchor, constant: -10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant:10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        
        contentView.addSubview(sourceDescriptionLabel)
        sourceDescriptionLabel.topAnchor.constraint(equalTo:nameLabel.bottomAnchor, constant: 5).isActive = true
        sourceDescriptionLabel.leadingAnchor.constraint(equalTo:contentView.leadingAnchor, constant: 10).isActive = true
        sourceDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        sourceDescriptionLabel.bottomAnchor.constraint(equalTo:contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    private func setData() {
        guard let news = news else { return }
        nameLabel.text = news.name
        sourceDescriptionLabel.text = news.sourceDescription
    }
}
