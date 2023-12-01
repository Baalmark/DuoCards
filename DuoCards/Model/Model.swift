//
//  Model.swift
//  DuoCards
//
//  Created by Pavel Goldman on 07.11.2023.
//

import Foundation
import UIKit


//MARK: Main Model
struct DuoCardsModel {
    var theme:Themes = .light
    var addedCards:[Card] = []
    var allCollections:[CardCollection] = loadedCollections
    var time:Date = Date()
    
}

//MARK: Main Card Struct
struct Card {
    var title: String
    var association: String
    var translation: String
    var translationOfAssociation:String
    var memoryStage:CardMemoryProgression
    var cardStatus:CardStatus
    var phase:LearningPhase
    
    init(title: String, association: String, translation: String, translationOfAssociation: String, memoryStage: CardMemoryProgression = .entry, cardStatus: CardStatus = .neutral, phase:LearningPhase) {
        self.title = title
        self.association = association
        self.translation = translation
        self.translationOfAssociation = translationOfAssociation
        self.memoryStage = memoryStage
        self.cardStatus = cardStatus
        self.phase = phase
    }
}

//MARK: Status of Card
enum CardStatus {
    case dismissOrKnown
    case neutral
    case toLearn
}

//MARK: Level of card collection
enum Level:String {
    case beginner = "beginner"
    case intermediate = "intermediate"
    case advanced = "advanced"
}

//MARK: Card memory progression // Learnin' progression
enum CardMemoryProgression {
    case entry //New word
    case second // Repeat after 5 min
    case third // Repeat after 30 min
    case fourth // Repeat after 2 hours
    case fifth // Repeat after 24 hours
    case sixth // Repeat after 48 hours
    case seventh // Repeat after 2 weeks
    case lastRepeat // Repeat after 1 month
    case learned // Learned
}
//MARK: Learning phase for card selecting
enum LearningPhase:String {
    case toLearn = "To Learn"
    case notCompleted = "Known"
    case completed = "Learned"
}

//MARK: Card Collection Struct
struct CardCollection {
    
    var cards:[Card]
    var title:String
    var description:String
    var level:Level
    var image:UIImage
    var cardStatus:CardStatus
}



enum Themes {
    case light
    case dark
    case pink
    case gold
}



//MARK: Extensions
//MARK:  UILable extension
extension UILabel {
    
    func addTrailing(image: UIImage?, text:String, color:UIColor) {
        
        
        if let img = image {
            
            let textAttachment = NSTextAttachment()
            
            let attributedStringWithImage = NSAttributedString(attachment: textAttachment);
            
            let stringToDisplay = text
            
            let fullAttributedString = NSMutableAttributedString(string:"\(stringToDisplay) ")
            fullAttributedString.addImageAttachment(image: img, font: .systemFont(ofSize: 30), textColor: color)
            //            fullAttributedString.append(attributedStringWithImage)
            
            self.attributedText = fullAttributedString
            
            let templateImage = img.withRenderingMode(.alwaysTemplate)
            
            textAttachment.image = templateImage
            
            fullAttributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: color,
                range: NSMakeRange(stringToDisplay.count, attributedStringWithImage.length))
        }
    }
    
    func addLeading(image: UIImage?, text:String, color:UIColor) {
        if let img = image {
            
            let textAttachment = NSTextAttachment()
            
            let attributedStringWithImage = NSAttributedString(attachment: textAttachment);
            
            let stringToDisplay = text
            
            let fullAttributedString = NSMutableAttributedString(string:"\(stringToDisplay) ")
            fullAttributedString.append(attributedStringWithImage)
            
            self.attributedText = fullAttributedString
            
            let templateImage = img.withRenderingMode(.alwaysTemplate)
            textAttachment.image = templateImage
            
            fullAttributedString.addAttribute(
                NSAttributedString.Key.foregroundColor,
                value: color,
                range: NSMakeRange(stringToDisplay.count, attributedStringWithImage.length))
        }
    }
    
}



//MARK: UIView extension
extension UIView {
    
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
    
    
    
}

//MARK: Static vars
extension DuoCardsModel {
    
    static let loadedCards:[Card] = [
        Card(title: "Hello", association: "Hell my friend", translation: "Привет", translationOfAssociation: "Привет мой друг", phase: .toLearn),
        Card(title: "I", association: "I spent my money", translation: "Я", translationOfAssociation: "Я потратил мои деньги", phase: .toLearn),
        Card(title: "You", association: "You are bad person", translation: "Ты", translationOfAssociation: "Ты плохой человек", phase: .toLearn),
        Card(title: "Bye", association: "Bye, my friend", translation: "Пока", translationOfAssociation: "Пока, мой друг", phase: .toLearn),
        Card(title: "Sun", association: "The sun i shining", translation: "Солнце", translationOfAssociation: "Солнце светит", phase: .toLearn),
        Card(title: "Mother", association: "Mother is cooking", translation: "Мама", translationOfAssociation: "Мама готовит кушать", phase: .toLearn),
        Card(title: "Father", association: "Father is going to the job", translation: "Папа", translationOfAssociation: "Папа идёт на работу", phase: .toLearn),
        Card(title: "Car", association: "The car rides upon the road", translation: "Машина", translationOfAssociation: "Машина едет по дороге", phase: .toLearn),
        Card(title: "Three", association: "The three growns up on the out-of-doors", translation: "Дерево", translationOfAssociation: "Дерево ростет во дворе", phase: .toLearn),
        Card(title: "Air", association: "There is a fresh air on the outdoors ", translation: "Воздух", translationOfAssociation: "На улице свежий воздух", phase: .toLearn),
        Card(title: "Light", association: "The light is shining brightly", translation: "Свет", translationOfAssociation: "Свет светит ярко", phase: .toLearn),
        Card(title: "He", association: "He stealed on my eyes the product from the shop", translation: "Он", translationOfAssociation: "Он украл на моих глазах товар с магазина", phase: .toLearn),
    ]
    
    
    static let loadedCollections:[CardCollection] =
    [
        CardCollection(cards: loadedCards, title: "Test title1", description: "Testing1", level: .beginner, image: UIImage(named: "TestImage") ?? UIImage(), cardStatus: .neutral),
        CardCollection(cards: loadedCards, title: "Test title2", description: "Testing2", level: .beginner, image: UIImage(named: "TestImage") ?? UIImage(), cardStatus: .neutral),
        CardCollection(cards: loadedCards, title: "Test title3", description: "Testing3", level: .beginner, image: UIImage(named: "TestImage") ?? UIImage(), cardStatus: .neutral),
        CardCollection(cards: loadedCards, title: "Test title4", description: "Testing4", level: .beginner, image: UIImage(named: "TestImage") ?? UIImage(), cardStatus: .neutral),
        CardCollection(cards: loadedCards, title: "Test title5", description: "Testing5", level: .beginner, image: UIImage(named: "TestImage") ?? UIImage(), cardStatus: .neutral),
        CardCollection(cards: loadedCards, title: "Test title6", description: "Testing6", level: .beginner, image: UIImage(named: "TestImage") ?? UIImage(), cardStatus: .neutral),
        
        
    ]
}



extension NSMutableAttributedString {
    func addImageAttachment(image: UIImage, font: UIFont, textColor: UIColor, size: CGSize? = nil) {
        let textAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: textColor,
            .foregroundColor: textColor,
            .font: font
        ]
        
        self.append(
            NSAttributedString.init(
                //U+200C (zero-width non-joiner) is a non-printing character. It will not paste unnecessary space.
                string: "\u{200c}",
                attributes: textAttributes
            )
        )
        
        let attachment = NSTextAttachment()
        attachment.image = image.withRenderingMode(.alwaysTemplate)
        //P.S. font.capHeight sets height of image equal to font size.
        let imageSize = size ?? CGSize.init(width: font.capHeight, height: font.capHeight)
        attachment.bounds = CGRect(
            x: 0,
            y: -font.capHeight / 4,
            width: imageSize.width,
            height: imageSize.height
        )
        let attachmentString = NSMutableAttributedString(attachment: attachment)
        attachmentString.addAttributes(
            textAttributes,
            range: NSMakeRange(
                0,
                attachmentString.length
            )
        )
        self.append(attachmentString)
    }
}

