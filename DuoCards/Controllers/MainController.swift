//
//  MainController.swift
//  DuoCards
//
//  Created by Pavel Goldman on 07.11.2023.
//

import Foundation
import UIKit

class MainController {
    
    static let shared = MainController(model: DuoCardsModel())
    
    private init(model:DuoCardsModel) {
        self.model = model
    }
    
    let model:DuoCardsModel
    
}
