import UIKit

class HeadlineViewController: UIViewController {
    
    //MARK: - let
    
    private let viewModel: HeadlineViewModel
    private let headlineTableView = UITableView()
    
    //MARK: - Lifecycle function
    
    init(viewModel: HeadlineViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
        setupNavigation()
        setupTableView()
        loadData()
    }
    
    //MARK: - Flow function
    
    private func loadData() {
        viewModel.load { [weak self] error in
            if let error = error {
                self?.showAlert("ERROR", error.localizedDescription)
            } else {
                self?.headlineTableView.reloadData()
            }
        }
    }
    
    private func setupNavigation() {
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupTableView() {
        headlineTableView.delegate = self
        headlineTableView.dataSource = self
        headlineTableView.register(HeadlineTableViewCell.self, forCellReuseIdentifier: HeadlineTableViewCell.reuseIdentifier)
        headlineTableView.separatorStyle = .none
    }
    
    private func addTableView() {
        view.addSubview(headlineTableView)
        headlineTableView.translatesAutoresizingMaskIntoConstraints = false
        headlineTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        headlineTableView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        headlineTableView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        headlineTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
}

extension HeadlineViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.article.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.reuseIdentifier, for: indexPath) as? HeadlineTableViewCell else { return UITableViewCell() }   
        cell.article = viewModel.article[indexPath.row]
        return cell
    }
}

extension HeadlineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.bounds.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.article[indexPath.row]
        let viewModel = DetailNewsViewModel(article: item)
        let controller = DetailNewsViewController(viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}


