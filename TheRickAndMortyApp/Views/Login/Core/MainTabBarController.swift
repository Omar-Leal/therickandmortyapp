//
//  ViewController.swift
//  TheRickAndMortyApp
//
//  Created by Omar Leal on 13/11/24.
//

import UIKit

class MainTabBarController: UITabBarController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#F1F2F6")
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.width, height: 44))
               view.addSubview(navigationBar)
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
                    navigationBar.shadowImage = UIImage() //
        
                   navigationBar.isTranslucent = true
                   navigationBar.backgroundColor = .clear
               
               // Crear un ítem de navegación
               let navigationItem = UINavigationItem(title: "Título Manual")
               
               // Botones en la barra
               let leftButton = UIBarButtonItem(title: "Atrás", style: .plain, target: self, action: #selector(backButtonTapped))
               let rightButton = UIBarButtonItem(title: "Guardar", style: .plain, target: self, action: #selector(saveButtonTapped))
               navigationItem.leftBarButtonItem = leftButton
               navigationItem.rightBarButtonItem = rightButton
               

               navigationBar.items = [navigationItem]

        
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let episodeViewController = UINavigationController(rootViewController: EpisodeViewController())
        let locationViewController = UINavigationController(rootViewController: EpisodeViewController())
        

                let logoImageView = UIImageView(image: UIImage(named: "rickandmortylogo"))
                logoImageView.contentMode = .scaleAspectFit
                logoImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 40) // Ajusta el tamaño según tu imagen
                
           
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
    @objc private func backButtonTapped() {}
    @objc private func saveButtonTapped() {}

}

