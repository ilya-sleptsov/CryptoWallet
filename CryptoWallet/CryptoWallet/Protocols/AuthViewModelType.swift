//
//  AuthViewModelType.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 27.04.2023.
//

import Foundation

protocol AuthViewModelType {
    var login: String { get }
    var password: String { get }
    
    func validateLogin(login: String, password: String) -> Bool
    
    func loginButtonTapped() -> Bool
}
