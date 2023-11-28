//
//  TypeOfDifficultyLabelView.swift
//  DuoCards
//
//  Created by Pavel Goldman on 28.11.2023.
//

import UIKit

class TypeOfDifficultyLabelView: UIView {

    
    var difficulty:Level?
    let diffLabel = UILabel()
    
    //MARK: Lazy vars
    lazy var mainView:UIView = {
        let view = UIView()
        let frame = CGRect(x: 0, y: 0, width: 50, height: 10)
        return view
    }()
    
    
    init(frame:CGRect,difficulty: Level) {
        self.difficulty = difficulty
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    func setupView() {
        
        if let difficulty = difficulty {
            diffLabel.text = difficulty.rawValue
            switch difficulty {
            case .beginner:
                mainView.backgroundColor = UIColor(named: "GreenColorCustom")?.withAlphaComponent(0.5)
                
            case .intermediate:
                mainView.backgroundColor = .systemBlue.withAlphaComponent(0.5)
                
            case .advanced:
                mainView.backgroundColor = .systemRed.withAlphaComponent(0.5)
            }
        }
        
        mainView.addSubview(diffLabel)
        self.addSubview(mainView)
    }
    
}
