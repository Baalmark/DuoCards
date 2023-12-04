//
//  CollectionsView.swift
//  DuoCards
//
//  Created by Pavel Goldman on 08.11.2023.
//

import UIKit

class CollectionsViewController: UIViewController {
    
    private let widthCollectionView:CGFloat = (UIScreen.main.bounds.width - 40)
    private let heightCollectionView:CGFloat = 180
    
    
    
    private let collectionViewStack:UIStackView = {
        let stack = UIStackView()
        stack.axis            = .vertical
        stack.distribution    = .fill
        stack.alignment       = .fill
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        
        return stack
    }()
    
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "BackGroundAccentColor")
        loadAllViews()
    }
    
    private func loadAllViews() {
        setScrollView()
    }
    
    //MARK: Add view to the StackView of Learning Phase Cards
    private func addViewToStackView() {
        let collections:[CardCollection] = DuoCardsModel.loadedCollections
        for coll in collections {
            print("Here")
            let frame = CGRect(x: 0, y: 0, width: widthCollectionView, height: heightCollectionView)
            let collectionView = CollectionView(frame: frame, collection: coll)
            collectionView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            collectionViewStack.addArrangedSubview(collectionView)
            
            //MARK: Custom tap gesture for Collection View
            let tap = SelectionCardTapGesture(target: self, action: #selector(didTapCollectionView(_:)))
            collectionView.addGestureRecognizer(tap)
        }
        
    }
    
    @objc private func didTapCollectionView(_ sender: SelectionCardTapGesture? = nil) {
        
        let selectionCardsViewController = SelectionCardCollectionViewController()
        
    }
    
    private func setScrollView() {
        let margins = view.layoutMarginsGuide
        view.addSubview(scrollView)
        scrollView.addSubview(collectionViewStack)
        
        //MARK: Constraints
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: margins.topAnchor,constant: 20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        
        collectionViewStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20).isActive = true
        collectionViewStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20).isActive = true
        collectionViewStack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        collectionViewStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        addViewToStackView()
        
    }
    
    
}

class SelectionCardTapGesture: UITapGestureRecognizer {
    var collection:CardCollection = CardCollection(cards: [], title: "", description: "", level: .beginner, image: UIImage(), cardStatus: .neutral)
}
