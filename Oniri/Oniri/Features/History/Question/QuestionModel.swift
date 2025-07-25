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

let questions: [Question] = [
    Question(question: "1", choice: ["a", "b"]),
    Question(question: "2", choice: ["c", "d"]),
    Question(question: "3", choice: ["e", "f"]),
    Question(question: "4", choice: ["g", "h"]),
    Question(question: "5", choice: ["i", "j"]),
    Question(question: "6", choice: ["k", "l"])
]
