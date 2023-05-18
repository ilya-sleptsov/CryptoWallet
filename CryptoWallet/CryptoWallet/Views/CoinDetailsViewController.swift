//
//  CoinDetailsViewController.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import UIKit
import SnapKit

class CoinDetailsViewController: UIViewController {
    
    private var viewModel: CoinDetailsViewModel
    var coin: Coin?
    
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let change24HoursLabel = UILabel()
    private let change1HourLabel = UILabel()
    
    init(viewModel: CoinDetailsViewModel, coin: Coin?) {
        self.viewModel = viewModel
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        nameLabel.text = viewModel.name
        
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        priceLabel.text = "Цена: \(viewModel.priceUsd) USD"
        
        change24HoursLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(change24HoursLabel)
        change24HoursLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(20)
        }
        change24HoursLabel.text = "Изменение цены за 24 часа: \(viewModel.change24Hours) %"
        
        change1HourLabel.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(change1HourLabel)
        change1HourLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(change24HoursLabel.snp.bottom).offset(20)
        }
        change1HourLabel.text = "Изменение цены за 1 час: \(viewModel.change1Hour) %"
    }
    
}

