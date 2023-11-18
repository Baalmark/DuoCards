//
//  ViewController.swift
//  DuoCards
//
//  Created by Pavel Goldman on 07.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var startButton:UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    let stackView = UIStackView()
    let widthView = (UIScreen.main.bounds.width - 80) / 3
    let backgroundImage = UIImage(named: "backgroundMain")
    let backgroundView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllViews()
        self.view.backgroundColor = UIColor(named: "BackGroundAccentColor")
    }
    
    
    func loadAllViews() {
        configureStackView()
        addConstraintToBackGroundImage()
        addConstraintToStartButton()
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        addViewToStackView()
        setStackViewConstraints()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints                                                          = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive           = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive   = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: widthView - 20).isActive                                              = true
    }
    
    
    func addViewToStackView() {
        let typesCards:[LearningPhase] = [LearningPhase.toLearn,LearningPhase.notCompleted,LearningPhase.completed]
        for typeCard in typesCards {
            let frame = CGRect(x: 0, y: 0, width: widthView, height: widthView)
            let countCards = MainController.shared.getCountOfCardsCertainPhase(phase: typeCard)
            let viewCard = CounterCertainTypesOfCardView(frame: frame, typeCard: typeCard, countCards: countCards)
            stackView.addArrangedSubview(viewCard)
        }
    }
    //MARK: Constraint to Background Image
    private func addConstraintToBackGroundImage() {
        view.addSubview(backgroundView)
        if let img = backgroundImage {
            backgroundView.image = img
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            backgroundView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 100).isActive = true
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
            backgroundView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        }
    }
    
    //MARK: Constraint to Start Button
    private func addConstraintToStartButton() {
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 100).isActive = true
        startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 60).isActive = true
        startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60).isActive = true
        startButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    
    
}

