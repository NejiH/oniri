//
//  QuestionModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import Foundation

class Question {
    var id = UUID()
    var question: String
    var choice: [String]
}
