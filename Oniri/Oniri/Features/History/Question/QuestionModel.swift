//
//  QuestionModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 15/07/2025.
//

import Foundation

enum Trait {
    case empathy
    case impulsivity
    case courage
    case resilience
    case ambition
    case altruism
    case perfectionism
    case stubbornness
    case charisma
    case anxiety
}

struct Choice {
    var text: String
    var destination: History
    var trait: Trait
}

struct Question {
    var id: Int
    var question: String
    var choices: [Choice]
    
    init(id: Int, question: String, choices: [Choice]) {
        self.id = id
        self.question = question
        self.choices = choices
    }
}

let questions: [Question] = [
    Question(id: 1, question: "Que fais-tu ?", choices: [ Choice(text: "Je suis la voix doucement, en chuchotant pour rassurer l’enfant.", destination: histories[1], trait: .empathy), Choice(text: "Je cours dans le labyrinthe, bravant les ombres sans réfléchir.", destination: histories[2], trait: .impulsivity)]),
    Question(id: 2, question: "Comment réagis-tu ?", choices: [Choice(text: "Je prends le temps d’écouter un objet, apaisant son souvenir.", destination: histories[3], trait: .empathy), Choice(text: "Tu ignores les murmures et ouvres la porte à toute volée.", destination: histories[4], trait: .impulsivity)]),
    Question(id: 3, question: "Que fais-tu ?", choices: [ Choice(text:"Tu tends la main vers Élior et tentes de communiquer par le regard.", destination: histories[5], trait: .empathy), Choice(text: "Tu plonges dans le torrent, décidée à le traverser à tout prix.", destination: histories[6], trait: .impulsivity)]),
    Question(id: 4, question: "Que fais-tu ?", choices: [Choice(text: "Je regarde les miroirs en silence, acceptant ses peurs.", destination: histories[7], trait: .empathy), Choice(text: "Je brise un miroir pour passer en force.", destination: histories[8], trait: .impulsivity)]),
    Question(id: 5, question: "Que fais-tu ?", choices: [Choice(text: "Je poses la main dessus avec douceur.", destination: histories[9], trait: .empathy), Choice(text: "J'essaie de le stabiliser par la force.", destination: histories[10], trait: .impulsivity)]),
    Question(id: 6, question: "Que fais-tu ?", choices: [Choice(text: "Je soutiens les piliers un à un.", destination: histories[11], trait: .empathy), Choice(text: "Je fonce vers la sortie avant que tout ne s'effondre.", destination: histories[12], trait: .impulsivity)]),
    Question(id: 7, question: "Que fais-tu ?", choices: [Choice(text: "Je m’approche et l’enlace.", destination: histories[13], trait: .empathy), Choice(text: "Je crie en retour pour te faire entendre.", destination: histories[14], trait: .impulsivity)])
]
