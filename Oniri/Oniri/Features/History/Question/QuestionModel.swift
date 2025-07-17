//
//  QuestionModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import Foundation

struct Question {
    var id = UUID()
    var question: String
    var choice: [String]
    
    init(question: String, choice: [String]) {
        self.question = question
        self.choice = choice
    }
}
