//
//  AuthServices.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 13/11/24.
//

import Foundation
import FirebaseAuth
import Combine

protocol AuthServiceProtocol {
    var currentUser: CurrentValueSubject<User?, Never> { get }
    func signIn(email: String, password: String) -> AnyPublisher<User, Error>

    func fetchUserData() -> AnyPublisher<UserData, Error>
}

class AuthService: AuthServiceProtocol {
    var currentUser = CurrentValueSubject<User?, Never>(Auth.auth().currentUser)
    
    init() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            self?.currentUser.send(user)
        }
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<User, Error> {
        Future { promise in
                  Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                      if let user = authResult?.user {
                          promise(.success(user))
                      } else if let error = error {
                          promise(.failure(error))
                      }
                  }
              }.eraseToAnyPublisher()
    }
    
    func fetchUserData() -> AnyPublisher<UserData, Error> {
        guard let user = Auth.auth().currentUser else {
            return Fail(error: NSError(domain: "AuthError", code: 401, userInfo: [NSLocalizedDescriptionKey: "No user logged in"]))
                .eraseToAnyPublisher()
        }
        return Future { promise in
            user.getIDToken { token, error in
                if let token = token {
                    let userData = UserData(uid: user.uid, displayName: user.displayName, photoUrl: user.photoURL, token: token)
                    promise(.success(userData))
                } else if let error = error {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}



