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
        let mainViewLeftButton = UIImage(systemName: "paintpalette.fill")
        let mainViewRightButton = UIImage(systemName: "chart.bar.xaxis")
        let mainView = self.createNav(with: "Home", and: homeImage,leftButtonImage: mainViewLeftButton, rightButtonImage: mainViewRightButton, vc: MainView())
        
        let collectionImage = UIImage(systemName: "book.fill")
        let collViewLeftButton = UIImage(systemName: "rectangle.and.text.magnifyingglass")
        let collViewRightButton = UIImage(systemName: "line.3.horizontal")
        let collectionView = self.createNav(with: "Collection", and: collectionImage,leftButtonImage: collViewLeftButton, rightButtonImage: collViewRightButton, vc: CollectionsView())
        
        let userImage = UIImage(systemName: "person.fill")
        let userView = self.createNav(with: "User", and: userImage, vc: UserView())
        
        self.setViewControllers([mainView,collectionView,userView], animated: true)
        
    }
    
    private func createNav(with title:String, and image:UIImage?,leftButtonImage:UIImage? = nil, rightButtonImage:UIImage? = nil, vc:UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.navigationBar.backgroundColor = .white
        nav.viewControllers.first?.navigationItem.title = title
        
        // Navigation bar standart appearance (Merges with status bar)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        nav.navigationBar.standardAppearance = appearance;
        nav.navigationBar.scrollEdgeAppearance = nav.navigationBar.standardAppearance
        
        if leftButtonImage != nil {
            let leftButton = UIBarButtonItem()
            leftButton.image = leftButtonImage
            leftButton.tintColor = .black
            nav.viewControllers.first?.navigationItem.leftBarButtonItem = leftButton
        }
        
        if rightButtonImage != nil {
            let rightButton = UIBarButtonItem()
            rightButton.image = rightButtonImage
            rightButton.tintColor = .black
            nav.viewControllers.first?.navigationItem.rightBarButtonItem = rightButton
            
        }
        return nav
        
    }
    


}
