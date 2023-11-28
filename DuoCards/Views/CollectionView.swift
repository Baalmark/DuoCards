//
//  CollectionView.swift
//  DuoCards
//
//  Created by Pavel Goldman on 28.11.2023.
//

import UIKit

class CollectionView: UIView {

    var collection: CardCollection?
    let widthView:CGFloat = (UIScreen.main.bounds.width - 50) / 2
    let imageCount = UIImage(systemName: "square.filled.on.square")
    
    //MARK: Lazy vars
    lazy var difficultyLabelView: UIView = {
        if let difficulty = collection?.level {
            let diffLabelView = TypeOfDifficultyLabelView(frame: CGRect(x: 0, y: 0, width: 50, height: 10), difficulty: difficulty)
            return diffLabelView
        } else {
            let diffLabelView = UIView()
            return diffLabelView
        }
    }()
    
    lazy var imageView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: widthView, height:widthView))
        if let img = collection?.image {
            imageView.image = img
        }
        
        return imageView
    }()
    
    
    lazy var countTitle: UILabel = {
        let countTitle = UILabel(frame: CGRect(x: 0, y: 15, width: 20, height: 10))
        if let count = collection?.cards.count { countTitle.text = String(count)
            let text = String(count)
            countTitle.font = UIFont.systemFont(ofSize: 10, weight: .medium)
            countTitle.textAlignment = .center
            countTitle.addTrailing(image: imageCount, text: text, color: UIColor(named: "GreenColorCustom") ?? .green)
        }
        return countTitle
    }()
    
    
    lazy var headerTitle: UILabel = {
        let headerTitle = UILabel(frame: CGRect(x: 0, y: 55, width: widthView, height: 30))
        headerTitle.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        headerTitle.textAlignment = .center
        headerTitle.text = collection?.title
        return headerTitle
    }()
    
    lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: widthView, height: 60))
        headerView.backgroundColor = .white
        headerView.addSubview(headerTitle)
        headerView.addSubview(countTitle)
        return headerView
    }()
    
    
    lazy var mainView: UIView = {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: widthView, height: 300))
        mainView.backgroundColor = .white
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.gray.cgColor
        mainView.layer.cornerRadius = 5
        mainView.addSubview(headerView)
        mainView.addSubview(imageView)
        mainView.addSubview(difficultyLabelView)
        return mainView
    }()
    
    init(frame:CGRect,collection:CardCollection) {
        self.collection = collection
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    func setupView() {
        self.addSubview(mainView)
        mainView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        mainView.backgroundColor = UIColor.cyan
    }
}
