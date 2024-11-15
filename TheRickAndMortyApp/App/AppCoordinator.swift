//
//  AppCoordinator.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 15/11/24.
//

import UIKit
import FirebaseAuth
import Combine

class AppCoordinator {
    private var window: UIWindow
    private var authStateListenerHandle: AuthStateDidChangeListenerHandle?

    init(window: UIWindow) {
        self.window = window
    }
    
    var currentUser: User? {
            Auth.auth().currentUser
        }
        
        func checkAuthState() -> AnyPublisher<Bool, Never> {
            return Future<Bool, Never> { promise in
                Auth.auth().addStateDidChangeListener { _, user in
                    promise(.success(user != nil))
                }
            }.eraseToAnyPublisher()
        }
    
    

    func start() {
        // Escuchar el estado de autenticación de Firebase
        authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            if let user = user {
                // El usuario está logueado, navegar a la pantalla principal
                self?.showHomeScreen()
            } else {
                // El usuario no está logueado, navegar a la pantalla de login
                self?.showLoginScreen()
            }
        }

        // Inicialmente, muestra la pantalla correcta basándote en el estado de autenticación
        if Auth.auth().currentUser != nil {
            // El usuario está logueado
            showHomeScreen()
        } else {
            // El usuario no está logueado
            showLoginScreen()
        }
    }

    private func showHomeScreen() {
        let mainTabBarController = MainTabBarController()
        window.rootViewController = UINavigationController(rootViewController: mainTabBarController)
        window.makeKeyAndVisible()
    }

    private func showLoginScreen() {
        let loginViewController = LoginViewController(viewModel: LoginViewModel(authService: AuthService()))
        window.rootViewController = UINavigationController(rootViewController: loginViewController)
        window.makeKeyAndVisible()
    }

    deinit {
        // Eliminar el listener cuando el AppCoordinator se destruye
        if let handle = authStateListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
