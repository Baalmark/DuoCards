//
//  SearchCardsView.swift
//  DuoCards
//
//  Created by Pavel Goldman on 24.11.2023.
//

import UIKit

class SearchCardsView: UIView {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        configureSearchCardsStackView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSearchCardsStackView()
    }
    
    //MARK: Lazy vars
    lazy var searchButton:UIButton = getSearchButton()
    lazy var searchCardsStackView:UIStackView = getSearchCardsStackView()
    lazy var showCardsButton:UIButton = {
        let showCardsButton = UIButton()
        showCardsButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        showCardsButton.setTitle(" Cards",
                for: .normal)
        showCardsButton.semanticContentAttribute = .forceLeftToRight
        showCardsButton.tintColor = .black
        showCardsButton.setTitleColor(.black, for: .normal)
        showCardsButton.setImage(MainController.shared.isShowedCardList ? chevron_up : chevron_down, for: .normal)
        showCardsButton.addTarget(self, action: #selector(showCardList), for: .touchUpInside)
        return showCardsButton
    }()
    
    lazy var chevron_down:UIImage? =  {
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .default)
        let image = UIImage(systemName: "chevron.compact.down",withConfiguration: config)
        return image
    }()
    
    lazy var chevron_up:UIImage? =  {
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .default)
        let image = UIImage(systemName: "chevron.compact.up",withConfiguration: config)
        return image
    }()
    
    //MARK: Configure the Search Cards Stack View
    private func configureSearchCardsStackView() {
        self.addSubview(searchCardsStackView)
    }

    private func getSearchButton() -> UIButton {
        let searchButton = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .medium, scale: .default)
        searchButton.tintColor = .gray
        searchButton.layer.opacity = 0.7
        searchButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        searchButton.setImage(UIImage(systemName: "magnifyingglass", withConfiguration: config), for: .normal)
        searchButton.addTarget(self, action: #selector(searchCardsButton), for: .touchUpInside)
        searchButton.sizeToFit()
        
        
        
        
        
        
        return searchButton
    }
    
    private func getSearchCardsStackView() -> UIStackView {
        let searchCardsStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        searchCardsStackView.layer.borderWidth = 0.5
        searchCardsStackView.layer.borderColor = UIColor.gray.cgColor
        searchCardsStackView.backgroundColor = .white
        searchCardsStackView.layer.cornerRadius = 4
        
        searchCardsStackView.axis = .horizontal
        searchCardsStackView.distribution = .equalCentering
        searchCardsStackView.spacing = 5
        
        //Spacer
        let spacer = UIView()
        
        //MARK: Constraints
        // maximum width constraint
        let spacerWidthConstraint = spacer.widthAnchor.constraint(equalToConstant: .greatestFiniteMagnitude) // or some very high constant
        spacerWidthConstraint.priority = .defaultLow // ensures it will not "overgrow"
        spacerWidthConstraint.isActive = true
        
        searchCardsStackView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
        searchCardsStackView.isLayoutMarginsRelativeArrangement = true
        
        
        
        
        //Add all views inside the StackView
        searchCardsStackView.addArrangedSubview(showCardsButton)
        searchCardsStackView.addArrangedSubview(spacer)
        
        if searchCardsStackView.arrangedSubviews.count > 0 {
            let separator = UIView()
            separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
            separator.backgroundColor = .gray
            searchCardsStackView.addArrangedSubview(separator)
            separator.heightAnchor.constraint(equalTo: searchCardsStackView.heightAnchor, multiplier: 0.6).isActive = true
        }
        
        searchCardsStackView.addArrangedSubview(searchButton)
    
        
        return searchCardsStackView
    }
    
    @objc func searchCardsButton() {
        print("Search views appears")
    }
    
    @objc func showCardList(_ sender: UIButton) {
        print(MainController.shared.isShowedCardList)
        MainController.shared.isShowedCardList.toggle()
        showCardsButton.setImage(MainController.shared.isShowedCardList ? chevron_up : chevron_down, for: .normal)
    }
}
