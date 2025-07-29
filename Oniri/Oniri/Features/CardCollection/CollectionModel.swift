//
//  CollectionModel.swift
//  Oniri
//
//  Created by apprenant152 on 17/07/2025.
//

import Foundation

struct Collection{
    var nbCard: Int
    var cards: [Cards]
}

var cardsCollection = Collection(
    nbCard: 20,
    cards: [
        Cards(name: "Patience", image: "card-patience", description: "La patience est une vertu.", isLocked: false),
        Cards(name: "Créativité", image: "card-creativite", description: "Laisse parler ton imagination.", isLocked: false),
        Cards(name: "Bienveillance", image: "card-bienveillance", description: "Fais preuve de gentillesse.", isLocked: false),
        Cards(name: "Empathie", image: "card-optimist", description: "Comprendre les autres profondément.", isLocked: false),
        Cards(name: "Courage", image: "card-courage", description: "Avance malgré la peur.", isLocked: false),
        Cards(name: "Liberté", image: "card-empathie", description: "Exprime-toi librement.", isLocked: true),
        Cards(name: "Sérénité", image: "card-serenite", description: "Reste calme en toute situation.", isLocked: true),
        Cards(name: "Respect", image: "card-respect", description: "Accepte les différences.", isLocked: true),
        Cards(name: "Écoute", image: "card-ecoute", description: "Sois attentif aux autres.", isLocked: true),
        Cards(name: "Joie", image: "card-joie", description: "Apprécie les petits moments.", isLocked: true),
        Cards(name: "Gratitude", image: "card-gratitude", description: "Remercie pour ce que tu as.", isLocked: true),
        Cards(name: "Responsabilité", image: "card-responsabilite", description: "Sois maître de tes choix.", isLocked: true),
        Cards(name: "Honnêteté", image: "card-honnetete", description: "Sois vrai avec toi-même et les autres.", isLocked: true),
        Cards(name: "Tolérance", image: "card-tolerance", description: "Accepte les points de vue différents.", isLocked: true),
        Cards(name: "Optimisme", image: "card-optimisme", description: "Crois en un avenir positif.", isLocked: true),
        Cards(name: "Confiance", image: "card-confiance", description: "Crois en toi.", isLocked: true),
        Cards(name: "Humilité", image: "card-humilite", description: "Reconnais que tu peux toujours apprendre.", isLocked: true),
        Cards(name: "Équilibre", image: "card-equilibre", description: "Harmonise travail et repos.", isLocked: true),
        Cards(name: "Générosité", image: "card-generosite", description: "Donne sans attendre en retour.", isLocked: true),
        Cards(name: "Amour", image: "card-amour", description: "Aime sans condition.", isLocked: true)
    ]
)
