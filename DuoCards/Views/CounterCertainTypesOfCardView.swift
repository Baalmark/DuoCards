//
//  CounterCertainTypesOfCardController.swift
//  DuoCards
//
//  Created by Pavel Goldman on 17.11.2023.
//

import UIKit

class CounterCertainTypesOfCardView: UIView {
    
    var typeCard: LearningPhase?
    var countCards: Int?
    let widthView = (UIScreen.main.bounds.width - 80) / 3
    
    //we use lazy properties for each view
    
    lazy var headerTitle: UILabel = {
        let headerTitle = UILabel(frame: CGRect(x: 0, y: 55, width: widthView, height: 20))
        headerTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        headerTitle.textAlignment = .center
        return headerTitle
    }()
    
    lazy var countTitle: UILabel = {
        let countTitle = UILabel(frame: CGRect(x: 0, y: 15, width: widthView, height: 30))
        if let count = countCards { countTitle.text = String(count) }
        countTitle.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        countTitle.textAlignment = .center
        return countTitle
    }()
    
    lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: widthView, height: widthView - 20))
        headerView.backgroundColor = .white
        headerView.layer.borderWidth = 0.5
        headerView.layer.borderColor = UIColor.gray.cgColor
        headerView.layer.cornerRadius = 5
        headerView.addSubview(headerTitle)
        headerView.addSubview(countTitle)
        return headerView
    }()
    
    init(frame:CGRect,typeCard: LearningPhase, countCards: Int) {
        self.typeCard = typeCard
        self.countCards = countCards
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    func setupView() {
        let imageQuestionMark = UIImage(systemName: "questionmark.circle")
        
        if let type = typeCard {
            switch type {
            case .toLearn:
                countTitle.textColor = UIColor(named: "GreenColorCustom")
                headerTitle.textColor = UIColor(named: "GreenColorCustom")
                headerTitle.addTrailing(image: imageQuestionMark, text: type.rawValue, color: UIColor(named: "GreenColorCustom") ?? .green)
                
            case .notCompleted:
                countTitle.textColor = .systemBlue
                headerTitle.textColor = .systemBlue
                headerTitle.addTrailing(image: imageQuestionMark, text: type.rawValue, color: .systemBlue)
            case .completed:
                countTitle.textColor = .systemYellow
                headerTitle.textColor = .systemYellow
                headerTitle.addTrailing(image: imageQuestionMark, text: type.rawValue, color: .systemYellow)
            }
        }
        self.addSubview(headerView)
    }
    
}
