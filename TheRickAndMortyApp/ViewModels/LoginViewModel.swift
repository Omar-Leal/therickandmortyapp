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
    static let shared = AuthService()
    
    @Published var isLoggedIn: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    @Published var emailError: String?
    @Published var passwordError: String?
    
    // para asignar la navegacion
    let loginSuccess = PassthroughSubject<Void, Never>()
    
    

    init(authService: AuthServiceProtocol) {
        self.authService = authService
       
    }
    
    private func observeAuthState() {
           AuthService.shared.checkAuthState()
               .receive(on: DispatchQueue.main)
               .assign(to: \.isLoggedIn, on: self)
               .store(in: &cancellables)
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
                self?.loginSuccess.send()
            })
            .store(in: &cancellables)
    }
    
    func signOut() {
           do {
               try AuthService.shared.signOut()
               isLoggedIn = false // Actualiza el estado manualmente
           } catch let error {
               print("Error al cerrar sesión: \(error.localizedDescription)")
           }
       }
    
}
