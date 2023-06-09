//
//  CoinsListViewModel.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import Foundation

class CoinsListViewModel: CoinsListViewModelType {
    
    var coins: [Coin] = []
    
    // MARK: - Fetching Data
    
    func fetchCoinData(completion: @escaping () -> Void) {
        
        let coinsList = ["btc", "eth", "tron", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
        
        let dispatchGroup = DispatchGroup()
        
        for coin in coinsList {
            
            dispatchGroup.enter()
            
            let urlString = "https://data.messari.io/api/v1/assets/\(coin)/metrics"
            guard let url = URL(string: urlString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    dispatchGroup.leave()
                    return
                }
                
                print(String(data: data, encoding: .utf8) ?? "Unable to convert data to string")
                
                do {
                    let coinData = try JSONDecoder().decode(CoinData.self, from: data)
                    let coinModel = Coin(name: coinData.data.name, marketData: coinData.data.marketData)
                    
                    DispatchQueue.main.async {
                        self.coins.append(coinModel)
                    }
                    
                    dispatchGroup.leave()
                } catch let error {
                    print("Error decoding JSON: \(error)")
                    dispatchGroup.leave()
                }
            }
            task.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            completion()
        }
        
    }
    
    // MARK: - Formatted values
    
    func formattedPrice(for coin: Coin) -> String {
        let priceString = String(format: "%.2f", coin.marketData?.priceUsd ?? 0.0)
        return "Цена: \(priceString) USD"
    }
    
    func formattedChange1Hour(for coin: Coin) -> String {
        let change1HourString = String(format: "%.2f", coin.marketData?.change1Hour ?? 0.0)
        return "Изменение за 1 час: \(change1HourString) %"
    }
    
    func formattedChange24Hours(for coin: Coin) -> String {
        let change24HoursString = String(format: "%.2f", coin.marketData?.change24Hours ?? 0.0)
        return "Изменение за 24 часа: \(change24HoursString) %"
    }
    
    // MARK: - Sorting coins
    
    func sortCoins(by time: SortTime, ascending: Bool) {
        switch time {
        case .hour:
            if ascending {
                coins.sort {
                    $0.marketData?.change1Hour ?? 0.0 < $1.marketData?.change1Hour ?? 0.0
                }
            } else {
                coins.sort {
                    $0.marketData?.change1Hour ?? 0.0 > $1.marketData?.change1Hour ?? 0.0
                }
            }
        case .twentyFourHours:
            if ascending {
                coins.sort {
                    $0.marketData?.change24Hours ?? 0.0 < $1.marketData?.change24Hours ?? 0.0
                }
            } else {
                coins.sort {
                    $0.marketData?.change24Hours ?? 0.0 > $1.marketData?.change24Hours ?? 0.0
                }
            }
        }
    }
}
