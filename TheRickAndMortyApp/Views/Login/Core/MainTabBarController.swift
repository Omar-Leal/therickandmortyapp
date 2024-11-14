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
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let episodeViewController = UINavigationController(rootViewController: EpisodeViewController())
        let locationViewController = UINavigationController(rootViewController: EpisodeViewController())
        
        
        // Asign an Image to each tabview
        homeViewController.tabBarItem.image = UIImage(systemName: "house.circle")
        homeViewController.tabBarItem.selectedImage = UIImage(systemName: "house.circle.fill")
        
        episodeViewController.tabBarItem.image = UIImage(systemName: "house.circle")
        episodeViewController.tabBarItem.selectedImage = UIImage(systemName: "house.circle.fill")
        
        locationViewController.tabBarItem.image = UIImage(systemName: "house.circle")
        locationViewController.tabBarItem.selectedImage = UIImage(systemName: "house.circle.fill")
        
        let puttinTogetherAllViewControllers = [ homeViewController, episodeViewController,  locationViewController ]
        
        setViewControllers(puttinTogetherAllViewControllers, animated: true)
        
        
    }


}

