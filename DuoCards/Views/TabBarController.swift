//
//  TabBarController.swift
//  DuoCards
//
//  Created by Pavel Goldman on 08.11.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTaps()
        self.tabBar.tintColor = .systemBlue
        self.tabBar.backgroundColor = .white
        self.tabBar.unselectedItemTintColor = .gray
        
    }
    
    
    
        //MARK: - Tab setup
    
    private func setupTaps() {
        
        let homeImage = UIImage(systemName: "rectangle.portrait.on.rectangle.portrait.angled.fill")
        let mainView = self.createNav(with: "Home", and: homeImage, vc: MainView())
        
        let collectionImage = UIImage(systemName: "book.fill")
        let collectionView = self.createNav(with: "Collection", and: collectionImage, vc: CollectionsView())
        
        let userImage = UIImage(systemName: "person.fill")
        let userView = self.createNav(with: "User", and: userImage, vc: UserView())
        self.setViewControllers([mainView,collectionView,userView], animated: true)
        
    }
    
    private func createNav(with title:String, and image:UIImage?, vc:UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.navigationBar.backgroundColor = .white
        nav.viewControllers.first?.navigationItem.title = title
        return nav
        
    }

}
