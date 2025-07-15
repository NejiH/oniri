//
//  HistoryModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import Foundation

class History {
    var title: String
    var narrative: String
    var image: [String]
    var question: [Question]
    
    init(title: String, narrative: String, image: [String], question: [Question]) {
        self.title = title
        self.narrative = narrative
        self.image = image
        self.question = question
    }
}
