//
//  CoinsListViewModelType.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 27.04.2023.
//

import Foundation

enum SortTime {
    case hour
    case twentyFourHours
}

protocol CoinsListViewModelType {
    var coins: [Coin] { get }
    
    func fetchCoinData(completion: @escaping () -> Void)
    
    func sortCoins(by time: SortTime, ascending: Bool)
}
