import UIKit

class SourceViewController: UIViewController {
    
    //MARK: - var
    
    private var menuItems: [UIAction] {
        SourceCategory.allCases.map { category in
            UIAction(title: category.rawValue) { [unowned self] _ in
                loadCategory(category: category)
            }
        }
    }
    
    private var categoryMenu: UIMenu {
        let allCategories = UIAction(title: "All categories") { [unowned self] _ in
            loadData()
        }
        let menu = UIMenu(title: "", options: .displayInline, children: menuItems)
        return UIMenu(title: "", children: [allCategories, menu])
    }
    
    //MARK: - let
    
    private let viewModel: SourceViewModel
    private let newsTableView = UITableView(frame: .zero, style: .insetGrouped)
    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        return loader
    }()
    
    //MARK: - Lifecycle function
    
    init(viewModel: SourceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        addTableView()
        setupNavigation()
        setupTableView()
        addLoader()
        loadData()
        
    }
    
    //MARK: - Flow function
    
    private func loadData() {
        viewModel.asyncLoad { [weak self] error in
            self?.loader.stopAnimating()
            if let error = error {
                self?.showAlert("ERROR", error.localizedDescription)
            } else {
                self?.newsTableView.reloadData()
            }
        }
        loader.startAnimating()
    }
    
    private func setupNavigation() {
        title = "News Source"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        newsTableView.delegate = self
        newsTableView.dataSource = self
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 70
    }
    
    private func addTableView() {
        view.addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        newsTableView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        newsTableView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    private func addLoader() {
        view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func configure() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "newspaper"), primaryAction: nil, menu: categoryMenu)
        
        view.backgroundColor = .systemBackground
    }
    
    private func loadCategory(category: SourceCategory) {
        viewModel.loadCategory(category: category) { [weak self] error in
            self?.loader.stopAnimating()
            if let error = error {
                self?.showAlert("ERROR", error.localizedDescription)
            } else {
                self?.newsTableView.reloadData()
            }
        }
        loader.startAnimating()
    }
}

extension SourceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.news = viewModel.news[indexPath.row]
        return cell
    }
}

extension SourceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let service = WebHeadlineService(service: CommonWebService())
        let id = viewModel.news[indexPath.row].id
        let viewModel = HeadlineViewModel(id: id, headline: service)
        let controller = HeadlineViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
