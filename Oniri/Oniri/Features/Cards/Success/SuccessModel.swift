//
//  SuccessModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 17/07/2025.
//

import Foundation

struct SuccessModel {
    var id = UUID()
    var card: Cards
    var description: String
}
    
    
    let testQuestions = [
        Question(question: "Oui monsieur ", choices: ["Oui", "Non"]),
        Question(question: "Oui madame ", choices: ["Oui", "Non"])
    ]
let testHistory = History(id: 1, title: "Route des Brumes",subtitle: "Sommeil léger", narrative: ["blabklablab"], image: ["":""], questions: "Que fais-tu ?", answer: ["Je suis la voix doucement, en chuchotant tout rassurer l'enfant", "Je cours dans le labyrinthe, bravant les ombres sans réfléchir"])
    let testPowers = Powers.magicPen
    let testCard = Cards(name: "Flamme Onirique", image: "card-patience", description: "Une carte qui vous offre une extrême patience afin de braver toutes formes de stresse.", isLocked: false)
    let testDream = Dream(
        title: "Le monde d'hurul",
        subtitle: "Le début d'une aventure",
        history: testHistory,
        powers: testPowers,
        card: [testCard],
        isSuccessful: true
    )
    let dreamVM = DreamViewModel(dream: testDream)
    let successVM = SuccessViewModel(from: dreamVM)


