//
//  ViewController.swift
//  DuoCards
//
//  Created by Pavel Goldman on 07.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let stackView = UIStackView()
    let widthView = (UIScreen.main.bounds.width - 80) / 3
    let backgroundImage = UIImage(named: "backgroundMain")
    let backgroundView = UIImageView()
    let SearchCardsStackView = SearchCardsView(frame: CGRect(x: 100, y: 200, width: 250, height: 50))
    
    //MARK: Lazy vars ( Some buttons / Views / StackViews etc. )
    
    lazy var startButton:UIButton = {
        let button = UIButton()
        button.setTitle("START", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(startLearningButton), for: .touchUpInside)
        setShadowUponTheButton(button)
        return button
    }()
    
    
    
    lazy var addCardButton:UIButton = {
        let button = UIButton(type: .custom)
        let config = UIImage.SymbolConfiguration(
            pointSize: 64, weight: .medium, scale: .default)
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        button.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: config), for: .normal)
        button.addTarget(self, action: #selector(addCustomCardButton), for: .touchUpInside)
        button.sizeToFit()
        setShadowUponTheButton(button)
        return button
    }()
    
    //MARK: No cards to learn message views on the main View
    lazy var messageView:UIStackView = {
        let someView = UIStackView()
        someView.backgroundColor = .clear
        return someView
    }()
    
    lazy var noCardsToLearnLabel:UILabel = {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllViews()
        self.view.backgroundColor = UIColor(named: "BackGroundAccentColor")
    }
    
    //MARK: Load all views function
    private func loadAllViews() {
        configureStackView()
        setSearchCardsStackViewConstraints()
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
    private func configureNoCardsMessage() {
        
        [self.noCardsToLearnLabel,
         self.addmoreCardsLabel,
         self.TestmeFromKnownCards].forEach { messageView.addArrangedSubview($0) }
        //Constraints
        noCardsMessageViewConstraints()
        
        messageView.axis = .vertical
        messageView.distribution = .fillEqually
        messageView.spacing = 10
    }
    
    //MARK: Configure the stackView
    private func configureStackView() {
        view.addSubview(stackView)
        addViewToStackView()
        setStackViewConstraints()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
    }
    
    
    //MARK: Set the shadow upon the Button
    private func setShadowUponTheButton(_ button: UIButton) {
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.33).cgColor
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 4.0
    }
    
    //MARK: Add view to the StackView of Learning Phase Cards
    private func addViewToStackView() {
        let typesCards:[LearningPhase] = [LearningPhase.toLearn,LearningPhase.notCompleted,LearningPhase.completed]
        for typeCard in typesCards {
            let frame = CGRect(x: 0, y: 0, width: widthView, height: widthView)
            let countCards = MainController.shared.getCountOfCardsCertainPhase(phase: typeCard)
            let viewCard = CounterCertainTypesOfCardView(frame: frame, typeCard: typeCard, countCards: countCards)
            stackView.addArrangedSubview(viewCard)
        }
    }
    
    //MARK: Create a label for no cards message
    private func getLabel(title:String,tapGesture:String? = nil) -> UILabel{
        
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
    
    //MARK: All @Objc func
    @objc func testKnownCardLabel(_ sender: UITapGestureRecognizer) {
        print("Testing")
    }
    @objc func addNewCollectionLabel(_ sender: UITapGestureRecognizer) {
        print("Adding")
    }
    
    @objc func addCustomCardButton(_ sender: UIButton) {
        print("Add new custom card")
    }
    @objc func startLearningButton(_ sender: UIButton!) {
        print("Start learning")
    }
    
    
    //MARK: All Constraints
    
    //MARK: Set constraint for Learning Phase StackView
    private func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints                                                           = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive            = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive    = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -17).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: widthView - 20).isActive                                   = true
    }
    
    //MARK: Set constraint for Search Cards Stack View
    private func setSearchCardsStackViewConstraints() {
        view.addSubview(SearchCardsStackView)
        SearchCardsStackView.translatesAutoresizingMaskIntoConstraints                                                          = false
        SearchCardsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive   = true
        SearchCardsStackView.heightAnchor.constraint(equalToConstant: 50).isActive                                              = true
        SearchCardsStackView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        SearchCardsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -25).isActive = true
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
        addCardButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        addCardButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        addCardButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
        addCardButton.widthAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    
    
}

