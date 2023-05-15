//
//  CoinDetailsViewController.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import UIKit

class CoinDetailsViewController: UIViewController {
    
    var coin: Coin?
    
    let nameLabel = UILabel()
    let priceLabel = UILabel()
    let change24HoursLabel = UILabel()
    let change1HourLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        setupConstraints()
        updateUI()

    }
    
    private func setupUI() {
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        change24HoursLabel.font = UIFont.systemFont(ofSize: 16)
        change1HourLabel.font = UIFont.systemFont(ofSize: 16)
        
        view.addSubview(nameLabel)
        view.addSubview(priceLabel)
        view.addSubview(change24HoursLabel)
        view.addSubview(change1HourLabel)
    }
    
    private func setupConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
        
        change24HoursLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).offset(20)
        }
        
        change1HourLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(change24HoursLabel.snp.bottom).offset(20)
        }
    }
    
    private func updateUI() {
        
        nameLabel.text = coin?.name ?? ""
        priceLabel.text = "Цена: \(String(format: "%.2f", coin?.marketData?.priceUsd ?? 0.0)) USD"
        change24HoursLabel.text = "Изменение цены за 24 часа: \(String(format: "%.2f", coin?.marketData?.change24Hours ?? 0.0)) %"
        change1HourLabel.text = "Изменение цены за 1 час: \(String(format: "%.2f", coin?.marketData?.change1Hour ?? 0.0)) %"
    }
}
