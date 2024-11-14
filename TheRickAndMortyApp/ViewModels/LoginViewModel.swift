//
//  LoginViewModel.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 13/11/24.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    private let authService: AuthServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    @Published var emailError: String?
    @Published var passwordError: String?
    
    @Published var loginStatus: Bool = false

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func signIn(email: String, password: String) {
        
        // Rapida y sencilla validacion de los inputs
        guard !email.isEmpty else {
                emailError = "Email no puede estar vacío."
                return
            }
            guard email.contains("@") else {
                emailError = "Ingresa un email válido."
                return
            }
            guard password.count >= 6 else {
                passwordError = "La contraseña debe tener al menos 6 caracteres."
                return
            }
        
            emailError = nil
            passwordError = nil
        
        authService.signIn(email: email, password: password)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Login error: \(error)")
                }
            }, receiveValue: { [weak self] _ in
                self?.loginStatus = true
            })
            .store(in: &cancellables)
    }
}
