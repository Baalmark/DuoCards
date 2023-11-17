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
    var allCollections:[CardCollection] = []
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
enum Level {
    case beginner
    case intermediate
    case advanced
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


extension UILabel {
    
    func addTrailing(image: UIImage?, text:String, color:UIColor) {
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
                value: UIColor.green,
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
                value: UIColor.green,
                range: NSMakeRange(stringToDisplay.count, attributedStringWithImage.length))
        }
    }
    
}


