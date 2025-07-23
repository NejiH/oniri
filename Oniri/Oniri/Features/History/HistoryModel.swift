//
//  HistoryModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import Foundation

struct History {
//    var id: String
    var title: String
//    var subtitle: [String]
    var narrative: [String]
    var image: [String: String]
    var questions: Question
    
    init(title: String, narrative: [String], image: [String: String], questions: Question) {
        self.title = title
        self.narrative = narrative
        self.image = image
        self.questions = questions
    }
    
}

let histories: [History] = [
    History(title: "Réve 1", narrative: ["part1"], image: ["start": "Pouet", "end": "sucess"], questions: questions[0]),
    History(title: "Réve 2.1", narrative: ["part1", "part2"], image: ["start": "Pouet", "end": "sucess"], questions: questions[1]),
    History(title: "Réve 2.2", narrative: ["part1", "part2"], image: ["start": "Pouet", "end": "sucess"], questions: questions[2]),
    History(title: "Réve 3.1", narrative: ["part1", "part2", "part3", "part 4"], image: ["start": "Pouet", "end": "sucess"], questions: questions[2]),
    History(title: "Réve 3.2", narrative: ["part1", "part2", "part3", "part 4"], image: ["start": "Pouet", "end": "sucess"], questions: questions[2]),
    History(title: "Réve 3.3", narrative: ["part1", "part2", "part3", "part 4"], image: ["start": "Pouet", "end": "sucess"], questions: questions[2]),
    History(title: "Réve 3.4", narrative: ["part1", "part2", "part3", "part 4"], image: ["start": "Pouet", "end": "sucess"], questions: questions[2]),
    History(title: "Réve 4", narrative: ["part1", "part2", "part3", "part 4"], image: ["start": "Pouet", "end": "sucess"], questions: questions[3])
]

