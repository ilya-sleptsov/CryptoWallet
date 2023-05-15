//
//  Coin.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import Foundation

struct CoinData: Codable {
    let data: Coin
}

struct Coin: Codable {
    let name: String?
    let marketData: MarketData?
    
    enum CodingKeys: String, CodingKey {
        case name
        case marketData = "market_data"
    }
}

struct MarketData: Codable {
    let priceUsd: Double?
    let change24Hours: Double?
    let change1Hour: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case change24Hours = "percent_change_usd_last_24_hours"
        case change1Hour = "percent_change_usd_last_1_hour"
    }
}
