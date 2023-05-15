//
//  CoinsListTableViewController.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import UIKit

class CoinsListTableViewController: UITableViewController {

    var viewModel = CoinsListViewModel()
    
    let coinsListTableView = UITableView()
    var coins: [Coin] = []
    
    private let logoutButton = UIButton()
    private let sortButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        viewModel.fetchCoinData {
            self.tableView.reloadData()
        }
        
        coinsListTableView.dataSource = self
        coinsListTableView.delegate = self
        view.addSubview(coinsListTableView)
        coinsListTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Выйти", style: .plain, target: self, action: #selector(logoutButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сортировать", style: .plain, target: self, action: #selector(sortButtonTapped))
        navigationItem.title = "Список монет"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.coins.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let coin = viewModel.coins[indexPath.row]
        
        if viewModel.isLoading == true {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            cell.accessoryView = spinner
            cell.textLabel?.text = "монета загружается"
        } else {
            cell.accessoryView = nil
            
            let priceString = String(format: "%.2f", coin.marketData?.priceUsd ?? 0.0)
            let change24HoursString = String(format: "%.2f", coin.marketData?.change24Hours ?? 0.0)
            let change1HourString = String(format: "%.2f", coin.marketData?.change1Hour ?? 0.0)

            let labelText = "\(coin.name ?? "")\nЦена: \(priceString) USD\nИзменение за 24 часа: \(change24HoursString) %\nИзменение за 1 час: \(change1HourString) %"
            
            cell.textLabel?.text = labelText
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.numberOfLines = 0
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coinDatailVC = CoinDetailsViewController()
        coinDatailVC.coin = viewModel.coins[indexPath.row]
        navigationController?.pushViewController(coinDatailVC, animated: true)
    }
    
    @objc func sortButtonTapped() {
        
        
        
    }

    @objc func logoutButtonTapped() {
        let authVC = AuthViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = authVC
    }
}



