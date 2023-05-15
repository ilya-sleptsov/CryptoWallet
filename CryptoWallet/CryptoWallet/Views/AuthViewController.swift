//
//  ViewController.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    let authViewModel = AuthViewModel()
    
    private let titleLabel = UILabel()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginStatusLabel = UILabel()
    private let passwordStatusLabel = UILabel()
    private let loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        
        loginTextField.placeholder = "Логин"
        loginTextField.borderStyle = .roundedRect
        view.addSubview(loginTextField)
        loginTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-30)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        titleLabel.text = "Крипто кошелек"
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginTextField.snp.top).offset(-60)
        }
        
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(30)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        loginStatusLabel.text = ""
        view.addSubview(loginStatusLabel)
        loginStatusLabel.snp.makeConstraints { make in
            make.centerX.equalTo(loginTextField.snp.centerX)
            make.top.equalTo(loginTextField.snp.bottom).offset(5)
        }
        
        passwordStatusLabel.text = ""
        view.addSubview(passwordStatusLabel)
        passwordStatusLabel.snp.makeConstraints { make in
            make.centerX.equalTo(passwordTextField.snp.centerX)
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
        }
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
        }
    }
    
    @objc private func loginButtonTapped() {
        if authViewModel.validateLogin(login: loginTextField.text ?? "", password: passwordTextField.text ?? "") {
            let alert = UIAlertController(title: "Добро пожаловать!", message: "Вход выполнен успешно!", preferredStyle: .alert)
            self.present(alert, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                alert.dismiss(animated: true, completion: {
                    let coinsListTableViewController = CoinsListTableViewController()
                    let navigationController = UINavigationController(rootViewController: coinsListTableViewController)
                    self.view.window?.rootViewController = navigationController
                })
            }
        } else {
            loginStatusLabel.text = "Неправильный логин или пароль"
            passwordStatusLabel.text = "Попробуйте еще раз!"
        }
    }
    
}

