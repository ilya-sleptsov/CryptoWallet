//
//  CoinDetailsViewModel.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import Foundation

class CoinDetailsViewModel {
    var coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var name: String {
        return coin.name ?? ""
    }
    
    var priceUsd: String {
        return String(format: "%.2f", coin.marketData?.priceUsd ?? 0.0)
    }
    
    var change24Hours: String {
        return String(format: "%.2f", coin.marketData?.change24Hours ?? 0.0)
    }
    
    var change1Hour: String {
        return String(format: "%.2f", coin.marketData?.change1Hour ?? 0.0)
    }
}
