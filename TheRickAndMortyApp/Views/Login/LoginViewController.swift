//
//  LoginViewController.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 13/11/24.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
        private var viewModel: LoginViewModel
        private var cancellables = Set<AnyCancellable>()
        
        // Logo
    
       private let mainLogo: UIImageView = {
         let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFit
         imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.image = UIImage(named: "Rick-and-Morty")
         return imageView
     }()
        private let emailTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Email"
            textField.borderStyle = .roundedRect
            textField.keyboardType = .emailAddress
            textField.autocapitalizationType = .none
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        private let emailErrorLabel: UILabel = {
            let label = UILabel()
            label.textColor = .red
            label.font = UIFont.systemFont(ofSize: 12)
            label.isHidden = true
            
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let passwordTextField: UITextField = {
            let textField = UITextField()
            textField.placeholder = "Password"
            textField.borderStyle = .roundedRect
            textField.isSecureTextEntry = true
            textField.translatesAutoresizingMaskIntoConstraints = false
            return textField
        }()
        
        private let passwordErrorLabel: UILabel = {
            let label = UILabel()
            label.textColor = .red
            label.font = UIFont.systemFont(ofSize: 12)
            label.isHidden = true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let loginButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Login", for: .normal)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        private let goToRegisterScreen: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Registrame", for: .normal)
            button.addTarget(self, action: #selector(didTapGoToRegisterScreen), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    
        init(viewModel: LoginViewModel) {
           self.viewModel = viewModel
           super.init(nibName: nil, bundle: nil)
       }
       
       required init(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBindings()
        settingUpConstraints()
       
    }
    

    private func settingUpConstraints() {
        
        [
         mainLogo,
         emailTextField,
         emailErrorLabel,
         emailErrorLabel,
         passwordTextField,
         loginButton,
         goToRegisterScreen].forEach(view.addSubview)
        
        
            
            
        NSLayoutConstraint.activate([
            mainLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5), // 50% del ancho
            mainLogo.heightAnchor.constraint(equalTo: mainLogo.widthAnchor, multiplier: 0.5),
            mainLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            mainLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
          

            emailTextField.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: -8),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            emailErrorLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 5),
            emailErrorLabel.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            emailErrorLabel.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),

            passwordTextField.topAnchor.constraint(equalTo: emailErrorLabel.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),

            passwordErrorLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 5),
            passwordErrorLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            passwordErrorLabel.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),

            loginButton.topAnchor.constraint(equalTo: passwordErrorLabel.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            goToRegisterScreen.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            goToRegisterScreen.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

        }
    
    
    
            private func setupBindings() {
            viewModel.$emailError
                .receive(on: DispatchQueue.main)
                .sink { [weak self] errorMessage in
                    self?.emailErrorLabel.text = errorMessage
                    self?.emailErrorLabel.isHidden = errorMessage == nil
                }
                .store(in: &cancellables)
            
            viewModel.$passwordError
                .receive(on: DispatchQueue.main)
                .sink { [weak self] errorMessage in
                    self?.passwordErrorLabel.text = errorMessage
                    self?.passwordErrorLabel.isHidden = errorMessage == nil
                }
                .store(in: &cancellables)
        }
        
        
    
    @objc private func didTapLoginButton()
       {
            guard let email = emailTextField.text, let password = passwordTextField.text else { return }
            viewModel.signIn(email: email, password: password)
           
        }
        
        @objc private func didTapGoToRegisterScreen() {
            let registerVC = RegisterViewController()
            navigationController?.pushViewController(registerVC, animated: true)
        }
    
    
   

}
