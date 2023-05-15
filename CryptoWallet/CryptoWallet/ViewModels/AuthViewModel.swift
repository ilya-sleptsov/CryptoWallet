//
//  AuthViewModel.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import Foundation

class AuthViewModel: AuthViewModelType {
    var login: String = ""
    var password: String = ""
    
    func validateLogin(login: String, password: String) -> Bool {
        return login == "1234" && password == "1234"
    }
    
    func loginButtonTapped() -> Bool {
        return validateLogin(login: login, password: password)
    }
}
