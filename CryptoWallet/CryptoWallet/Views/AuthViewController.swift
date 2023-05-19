//
//  ViewController.swift
//  CryptoWallet
//
//  Created by Илья Слепцов on 26.04.2023.
//

import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    private let authViewModel: AuthViewModel
    
    // MARK: - Initialization
    
    init(authViewModel: AuthViewModel) {
        self.authViewModel = authViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Subviews
    private let titleLabel = UILabel()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginStatusLabel = UILabel()
    private let passwordStatusLabel = UILabel()
    private let loginButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        view.backgroundColor = .white
        
        
        loginTextField.placeholder = "Логин"
        loginTextField.borderStyle = .roundedRect
        view.addSubview(loginTextField)
        loginTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-35)
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
            make.centerY.equalToSuperview().offset(35)
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
    
    // MARK: - Actions
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc private func loginButtonTapped() {
        authViewModel.login = loginTextField.text ?? ""
        authViewModel.password = passwordTextField.text ?? ""
        
        authViewModel.loginButtonTapped { [weak self] isSuccess in
            if  isSuccess {
                let alert = UIAlertController(title: "Добро пожаловать!", message: "Вход выполнен успешно!", preferredStyle: .alert)
                self?.present(alert, animated: true)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                    alert.dismiss(animated: true) {
                        self?.authViewModel.handleSuccessfulLogin()
                    }
                }
            } else {
                self?.loginStatusLabel.text = "Неправильный логин или пароль"
                self?.loginStatusLabel.textColor = .red
                self?.passwordStatusLabel.text = "Попробуйте еще раз!"
                self?.passwordStatusLabel.textColor = .red
            }
        }
    }
}

