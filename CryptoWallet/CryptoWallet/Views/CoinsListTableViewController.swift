//
//  CoinsListTableViewController.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import UIKit
import SnapKit

class CoinsListTableViewController: UITableViewController {
    
    private var viewModel: CoinsListViewModel
    private let coinsListTableView = UITableView()
    
    // MARK: - Initialization
    
    init(viewModel: CoinsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Subviews
    
    private let logoutButton = UIButton()
    private let sortButton = UIButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private var sortAlertController = UIAlertController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        coinsListTableView.dataSource = self
        coinsListTableView.delegate = self
        
        viewModel.fetchCoinData {
            self.activityIndicator.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сортировать", style: .plain, target: self, action: #selector(sortButtonTapped))
        navigationItem.title = "Список монет"
        
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        view.addSubview(coinsListTableView)
        coinsListTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        sortAlertController = UIAlertController(title: "Сортировать по изменению цены", message: nil, preferredStyle: .actionSheet)
        
        let sortAscendingBy1hAction = UIAlertAction(title: "за 1 час (по возрастанию)", style: .default) { _ in
            self.viewModel.sortCoins(by: .hour, ascending: true)
            self.tableView.reloadData()
        }
        
        let sortDescendingBy1hAction = UIAlertAction(title: "за 1 час (по убыванию)", style: .default) { _ in
            self.viewModel.sortCoins(by: .hour, ascending: false)
            self.tableView.reloadData()
        }
        
        let sortAscendingBy24hAction = UIAlertAction(title: "за 24 часа (по возрастанию)", style: .default) { _ in
            self.viewModel.sortCoins(by: .twentyFourHours, ascending: true)
            self.tableView.reloadData()
        }
        
        let sortDescendingBy24hAction = UIAlertAction(title: "за 24 часа (по убыванию)", style: .default) { _ in
            self.viewModel.sortCoins(by: .twentyFourHours, ascending: false)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        sortAlertController.addAction(sortAscendingBy1hAction)
        sortAlertController.addAction(sortDescendingBy1hAction)
        sortAlertController.addAction(sortAscendingBy24hAction)
        sortAlertController.addAction(sortDescendingBy24hAction)
        sortAlertController.addAction(cancelAction)
        
    }
    
    // MARK: - Actions
    
    @objc func sortButtonTapped() {
        present(sortAlertController, animated: true, completion: nil)
        tableView.reloadData()
    }
    
    @objc func logoutButtonTapped() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let user = appDelegate.fetchUser()
        user.isAuthorized = false
        try? appDelegate.context.save()
        
        let authViewModel = AuthViewModel()
        let authViewController = AuthViewController(authViewModel: authViewModel)
        appDelegate.window?.rootViewController = authViewController
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension CoinsListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let coin = viewModel.coins[indexPath.row]
        
        let priceString = viewModel.formattedPrice(for: coin)
        let change1HourString = viewModel.formattedChange1Hour(for: coin)
        let change24HoursString = viewModel.formattedChange24Hours(for: coin)
        
        let labelText = "\(coin.name ?? "")\n\(priceString)\n\(change1HourString)\n\(change24HoursString)"
        
        cell.textLabel?.text = labelText
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinDatailVC = CoinDetailsViewController(viewModel: CoinDetailsViewModel(coin: viewModel.coins[indexPath.row]), coin: viewModel.coins[indexPath.row])
        coinDatailVC.coin = viewModel.coins[indexPath.row]
        navigationController?.pushViewController(coinDatailVC, animated: true)
    }
}

