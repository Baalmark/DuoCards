//
//  ViewController.swift
//  DuoCards
//
//  Created by Pavel Goldman on 07.11.2023.
//

import UIKit

class MainView: UIViewController {

    private let mainView:UIView  = {
        let mainView = UIView()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.backgroundColor = UIColor(named: "BackGroundAccentColor")
        return mainView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(mainView)
        addConstraints()
        // Do any additional setup after loading the view.
    }
    
    private func addConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        // Add
        constraints.append(mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))

        // Activate (Applying)
        NSLayoutConstraint.activate(constraints)
    }

}

