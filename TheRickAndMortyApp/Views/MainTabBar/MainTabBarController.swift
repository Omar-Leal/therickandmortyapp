//
//  ViewController.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 13/11/24.
//

import UIKit

class MainTabBarController: UITabBarController  {
    private var viewModel = LoginViewModel(authService: AuthService())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F1F2F6")
      //  tabBar.isTranslucent = false
        
        let blurEffect = UIBlurEffect(style: .systemMaterial)


        let blurBackground = UIVisualEffectView(effect: blurEffect)
        blurBackground.frame = tabBar.bounds
        blurBackground.autoresizingMask = [.flexibleWidth, .flexibleHeight]


        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = blurEffect

        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 44))
               view.addSubview(navigationBar)
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
                    navigationBar.shadowImage = UIImage()
        
                   navigationBar.isTranslucent = true
                   navigationBar.backgroundColor = .clear
               
         
               let navigationItem = UINavigationItem(title: "")
               
      
               let leftButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(didTapSignOut))
               let rightButton = UIBarButtonItem(title: "Perfil", style: .plain, target: self, action: #selector(saveButtonTapped))
               navigationItem.leftBarButtonItem = leftButton
               navigationItem.rightBarButtonItem = rightButton
               navigationBar.items = [navigationItem]

        
        
                let homeViewController = UINavigationController(rootViewController: HomeViewController())
                let episodeViewController = UINavigationController(rootViewController: EpisodeViewController())
                let locationViewController = UINavigationController(rootViewController: EpisodeViewController())
        

                let logoImageView = UIImageView(image: UIImage(named: "Rick-and-Morty"))
                logoImageView.contentMode = .scaleAspectFit
                logoImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
                
           
                navigationItem.titleView = logoImageView
  
        homeViewController.tabBarItem.image = UIImage(systemName: "house.circle")
        homeViewController.tabBarItem.selectedImage = UIImage(systemName: "house.circle.fill")
        
        episodeViewController.tabBarItem.image = UIImage(systemName: "house.circle")
        episodeViewController.tabBarItem.selectedImage = UIImage(systemName: "house.circle.fill")
        
        locationViewController.tabBarItem.image = UIImage(systemName: "house.circle")
        locationViewController.tabBarItem.selectedImage = UIImage(systemName: "house.circle.fill")
        
        let puttinTogetherAllViewControllers = [ homeViewController, episodeViewController,  locationViewController ]
        
        setViewControllers(puttinTogetherAllViewControllers, animated: true)
        
        
        
    }
   
    @objc private func saveButtonTapped() {}
    
    @objc  func didTapSignOut() {
        print("cerrando sesion")
        viewModel.signOut()
               if !viewModel.isLoggedIn {
                   redirectToLogin()
               }
    }
    
    private func redirectToLogin() {
        let loginVC = LoginViewController(viewModel: LoginViewModel(authService: AuthService()))
            let navController = UINavigationController(rootViewController: loginVC)
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = navController
                window.makeKeyAndVisible()
            }
        }

}

