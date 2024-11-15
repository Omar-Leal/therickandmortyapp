//
//  RegisterViewModel.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 14/11/24.
//

import Foundation
import FirebaseAuth
import Combine

class RegisterViewModel {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isRegistered: Bool = false

    private var cancellables = Set<AnyCancellable>()
    
    func register() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Por favor, completa todos los campos."
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.errorMessage = "Error en el registro: \(error.localizedDescription)"
                return
            }
            self?.isRegistered = true
        }
    }
}
