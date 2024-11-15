//
//  RegisterViewController.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 14/11/24.
//

import UIKit
import Combine

class RegisterViewController: UIViewController {
    private let viewModel = RegisterViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Correo electrónico"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Contraseña"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Registrarse", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        [
            emailTextField,
            passwordTextField,
            registerButton,
            errorLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
           
        ])
    }
    
    private func setupBindings() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        viewModel.$errorMessage
            .receive(on: RunLoop.main)
            .sink { [weak self] errorMessage in
                self?.errorLabel.text = errorMessage
                self?.errorLabel.isHidden = errorMessage == nil
            }
            .store(in: &cancellables)
        
        viewModel.$isRegistered
            .receive(on: RunLoop.main)
            .sink { [weak self] isRegistered in
                if isRegistered {
                    self?.navigateToLogin()
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == emailTextField {
            viewModel.email = textField.text ?? ""
        } else if textField == passwordTextField {
            viewModel.password = textField.text ?? ""
        }
    }
    
    @objc private func didTapRegister() {
        viewModel.register()
    }
    
    private func navigateToLogin() {
        let loginViewController = LoginViewController(viewModel: LoginViewModel(authService: AuthService()))  // Asegúrate de instanciar tu LoginViewController
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}
