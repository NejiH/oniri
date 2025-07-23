//
//  HistoryModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import Foundation

struct History {
    var title: String
    var subtitle: String
    var narrative: String
    var image: [String]
    var questions: [Question]
    
    init(title: String, subtitle: String, narrative: String, image: [String], questions: [Question]) {
        self.title = title
        self.subtitle = subtitle
        self.narrative = narrative
        self.image = image
        self.questions = questions
    }
}
