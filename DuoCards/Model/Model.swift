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
    
    var addedCards:[Card] = []
    var allCollections:[CardCollection] = []
    var time:Date = Date.now    
    
}

//MARK: Main Card Struct
struct Card {
    var title: String
    var association: String
    var translation: String
    var translationOfAssociation:String
    var memoryStage:CardMemoryProgression
    var cardStatus:CardStatus
    
    init(title: String, association: String, translation: String, translationOfAssociation: String, memoryStage: CardMemoryProgression = .entry, cardStatus: CardStatus = .neutral) {
        self.title = title
        self.association = association
        self.translation = translation
        self.translationOfAssociation = translationOfAssociation
        self.memoryStage = memoryStage
        self.cardStatus = cardStatus
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
enum LearningPhase {
    case notStarted
    case notCompleted
    case completed
}

//MARK: Card Collection Struct
struct CardCollection {

    var cards:[Card]
    var title:String
    var description:String
    var level:Level
    var image:UIImage
    var phase:LearningPhase
}
