//
//  AuthViewModel.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import Foundation
import UIKit

class AuthViewModel: AuthViewModelType {
    var login: String = ""
    var password: String = ""
    
    func validateLogin() -> Bool {
        return login == "1234" && password == "1234"
    }
    
    func loginButtonTapped(completionHandler: @escaping (Bool) -> Void) {
        if validateLogin() {
            completionHandler(true)
        } else {
            completionHandler(false)
        }
    }
    
    func handleSuccessfulLogin() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let user = appDelegate.fetchUser()
        user.isAuthorized = true
        try? appDelegate.context.save()
        
        let coinsListViewModel = CoinsListViewModel()
        let coinsListTableViewController = CoinsListTableViewController(viewModel: coinsListViewModel)
        let navigationController = UINavigationController(rootViewController: coinsListTableViewController)
        appDelegate.window?.rootViewController = navigationController
    }
}
