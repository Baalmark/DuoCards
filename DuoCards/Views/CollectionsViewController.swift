//
//  CollectionsView.swift
//  DuoCards
//
//  Created by Pavel Goldman on 08.11.2023.
//

import UIKit

class CollectionsViewController: UIViewController {
    
    let widthCollectionView:CGFloat = (UIScreen.main.bounds.width - 50) / 2
    let heightCollectionView:CGFloat = 180
    
    
    
    private let collectionViewStack:UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.alignment = .fill
        return stack
    }()
    
    
    private let scrollView: UIScrollView = {
    let view = UIScrollView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
    }()

    private let subView1: UIView = {
    let view = UIView()
    view.heightAnchor.constraint(equalToConstant: 180).isActive = true
    view.backgroundColor = UIColor.blue
    return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "BackGroundAccentColor")
        loadAllViews()
    }
    
    private func loadAllViews() {
        setScrollView()
//        setStackViewConstraints(stackView: collectionViewStack)
    }
    
    //MARK: Add view to the StackView of Learning Phase Cards
    private func addViewToStackView() {
        let collections:[CardCollection] = DuoCardsModel.loadedCollections
        for coll in collections {
            print("Here")
            let frame = CGRect(x: 0, y: 0, width: widthCollectionView, height: heightCollectionView)
            let collectionView = CollectionView(frame: frame, collection: coll)
            collectionViewStack.addArrangedSubview(collectionView)
            
        }
        
        collectionViewStack.addArrangedSubview(subView1)
    }
    
    private func setScrollView() {
        let margins = view.layoutMarginsGuide
        view.addSubview(scrollView)
        
        scrollView.addSubview(collectionViewStack)
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        collectionViewStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        collectionViewStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        collectionViewStack.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        collectionViewStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        collectionViewStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        addViewToStackView()
        
    }
    
    
    private func configureContainerView() {
        collectionViewStack.addArrangedSubview(subView1)
    }
    
    
    //MARK: Constraints
    
    //MARK: Make constraint to main StackView
    private func setStackViewConstraints(stackView:UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints                                                           = false
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive            = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive    = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -17).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive     = true
    }
    
}
