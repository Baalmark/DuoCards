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
    
    lazy var addCardButton:UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.setImage(UIImage(systemName: "plus.square.fill.on.square.fill"), for: .normal)
        button.addTarget(self, action: #selector(addCustomCardButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: No cards to learn message views on the main View
    lazy var messageView:UIStackView = {
        let someView = UIStackView()
        someView.backgroundColor = .clear
        return someView
    }()
    
    lazy var noCardsToLearnLable:UILabel = {
        let label = UILabel()
        label.text = "No cards to learn at the moment"
        label.font = .systemFont(ofSize: 12,weight: .light)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    //Clickable labels
    lazy var addmoreCardsLabel:UILabel = getLabel(title: "Add more cards from library", tapGesture: "Adding")
    lazy var TestmeFromKnownCards:UILabel = getLabel(title: "Test me from known cards", tapGesture: "Testing")
    
    let stackView = UIStackView()
    let widthView = (UIScreen.main.bounds.width - 80) / 3
    let backgroundImage = UIImage(named: "backgroundMain")
    let backgroundView = UIImageView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllViews()
        self.view.backgroundColor = UIColor(named: "BackGroundAccentColor")
    }
    
    //MARK: Load all views function
    func loadAllViews() {
        configureStackView()
        addConstraintToBackGroundImage()
        addConstraintToAddCardButton()
        if MainController.shared.model.addedCards.filter({card in
            card.phase == .toLearn}).count >= 1 {
            addConstraintToStartButton()
        } else {
            configureNoCardsMessage()
        }
    }
    
    //MARK: Configure No Cards Message
    func configureNoCardsMessage() {
        
        [self.noCardsToLearnLable,
         self.addmoreCardsLabel,
         self.TestmeFromKnownCards].forEach { messageView.addArrangedSubview($0) }
        //Constraints
        noCardsMessageViewConstraints()
        
        messageView.axis = .vertical
        messageView.distribution = .fillEqually
        messageView.spacing = 10
    }
    
    func configureStackView() {
        view.addSubview(stackView)
        addViewToStackView()
        setStackViewConstraints()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
    }
    
    
    
    @objc func testKnownCardLabel(_ sender: UITapGestureRecognizer) {
        print("Testing")
    }
    @objc func addNewCollectionLabel(_ sender: UITapGestureRecognizer) {
        print("Adding")
    }
    
    @objc func addCustomCardButton() {
        print("Add new custom card")
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
    
    //MARK: Constraint to No cards message View
    private func noCardsMessageViewConstraints() {
        view.addSubview(messageView)
        messageView.translatesAutoresizingMaskIntoConstraints = false
        messageView.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 40).isActive = true
        messageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 60).isActive = true
        messageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60).isActive = true
        messageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    //MARK: Constraint to add Card Button
    private func addConstraintToAddCardButton() {
        view.addSubview(addCardButton)
        addCardButton.translatesAutoresizingMaskIntoConstraints = false
        addCardButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        addCardButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        addCardButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        addCardButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func getLabel(title:String,tapGesture:String? = nil) -> UILabel{
        
        let label = UILabel()
        let text = title
        label.font = .systemFont(ofSize: 12,weight: .light)
        label.textColor = .gray
        label.textAlignment = .center
        label.isUserInteractionEnabled = true
        
        if tapGesture != nil {
            //The line under the text
            let underlineAttriString = NSAttributedString(string: title,
                                                          attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
            label.attributedText = underlineAttriString
            // Create the gesture recognizer
            if tapGesture == "Testing" {
                let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.testKnownCardLabel))
                label.addGestureRecognizer(labelTapGesture)
            } else {
                let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.addNewCollectionLabel))
                label.addGestureRecognizer(labelTapGesture)
            }
        }
        return label
        
    }
    
    
}

