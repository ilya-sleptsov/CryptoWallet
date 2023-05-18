//
//  AuthViewModelType.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 27.04.2023.
//

import Foundation

protocol AuthViewModelType {
    var login: String { get set }
    var password: String { get set }
    
    func validateLogin() -> Bool
    
    func loginButtonTapped(completionHandler: @escaping (Bool) -> Void)
}
