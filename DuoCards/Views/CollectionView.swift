//
//  CollectionView.swift
//  DuoCards
//
//  Created by Pavel Goldman on 28.11.2023.
//

import UIKit

class CollectionView: UIView {

    var collection: CardCollection?
    
    let imageCount = UIImage(systemName: "square.filled.on.square")
    
    let widthMainView:CGFloat = (UIScreen.main.bounds.width - 40)
    
    let heightMainView:CGFloat = 300
    let heightHeaderView:CGFloat = 60
    let heightHeaderTitle:CGFloat = 30
    
    let heightCountTitle:CGFloat = 30
    let widthCountTitle:CGFloat = 100
    
    let frameImage:CGRect = CGRect(x:0,y:0,width: 200, height: 200)
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
        let imageView = UIImageView(frame: frameImage)
        if let img = collection?.image {
            imageView.image = img
        }
//        imageView.layer.borderColor = UIColor.red.cgColor
//        imageView.layer.borderWidth = 2
        return imageView
    }()
    
    
    lazy var countTitle: UILabel = {
        let countTitle = UILabel(frame: CGRect(x: 0, y: 20, width: widthCountTitle, height: heightCountTitle))
        if let count = collection?.cards.count { countTitle.text = String(count)
            let text = String(count)
            countTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            countTitle.textAlignment = .center
            countTitle.addTrailing(image: imageCount, text: text, color: UIColor(named: "GreenColorCustom") ?? .green)
            
        }
        return countTitle
    }()
    
    
    lazy var headerTitle: UILabel = {
        let headerTitle = UILabel(frame: CGRect(x: 0, y: 0, width: widthMainView, height: heightHeaderTitle))
        headerTitle.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        headerTitle.textAlignment = .center
        headerTitle.text = collection?.title
        return headerTitle
    }()
    
    
    
    lazy var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: heightMainView - heightHeaderView, width: widthMainView, height: heightHeaderView))
        headerView.backgroundColor = UIColor(named: "SubWhiteColor") ?? .white
        headerView.addBorders(edges: .top, color: UIColor(named: "SeparatorColor") ?? .black)
        headerView.addSubview(headerTitle)
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        headerView.layer.cornerRadius = 12
        headerView.addSubview(countTitle)
        
        
        return headerView
    }()
    
    
    lazy var mainView: UIView = {
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: widthMainView, height: heightMainView))
        mainView.backgroundColor = .white
        mainView.layer.borderWidth = 0.5
        mainView.layer.borderColor = UIColor.gray.cgColor
        mainView.layer.cornerRadius = 12
        mainView.addSubview(imageView)
        mainView.addSubview(headerView)
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
        mainView.backgroundColor = UIColor.white
        makeConstraints()
    }
    
    
    func makeConstraints() {
        
        mainView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        //Alignments Constraints
        imageView.center.y = mainView.center.y - (heightHeaderView / 2)
        imageView.center.x = mainView.center.x
        headerTitle.center.x = headerView.center.x
        countTitle.center.x = headerView.center.x
        countTitle.center.x = headerView.center.x
    }
}
