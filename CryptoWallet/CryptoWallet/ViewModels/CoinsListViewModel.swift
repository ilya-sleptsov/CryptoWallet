//
//  CoinsListViewModel.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import Foundation

class CoinsListViewModel {
    
    var coins: [Coin] = []
    var isLoading = false
    
    func fetchCoinData(completion: @escaping () -> Void) {
        
        isLoading = true
        
        let coinsList = ["btc", "eth", "tron", "polkadot", "dogecoin", "tether", "stellar", "cardano", "xrp"]
        
        let dispatchGroup = DispatchGroup()
        
        for coin in coinsList {
            
            dispatchGroup.enter()
            
            let urlString = "https://data.messari.io/api/v1/assets/\(coin)/metrics"
            guard let url = URL(string: urlString) else { continue }
            
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
                    self.coins.append(coinModel)
                    dispatchGroup.leave()
                } catch let error {
                    print("Error decoding JSON: \(error)")
                    dispatchGroup.leave()
                }
            }
            task.resume()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.isLoading = false
            completion()
        }
        
    }
}
