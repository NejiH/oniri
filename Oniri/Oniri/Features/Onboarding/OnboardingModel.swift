//
//  OnboardingModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 18/07/2025.
//

import Foundation

struct OnboardingModel {
    let title: String
    let text: String
    let icone: String
    let backgroundColor: String
    let textColor: String
    let buttonColor: String
    let buttonTextColor: String
}

let onboarding: [OnboardingModel] = [
    OnboardingModel(title: "Explore des rêves", text: "Plonge dans un univers onirique où chaque rêve est une aventure. Laisse-toi guider à travers des histoires uniques, mystérieuses et surprenantes, prêtes à révéler ce qui se cache au plus profond de toi.", icone: "icon-portal", backgroundColor: "soft-pink", textColor: "dream-black", buttonColor: "mid-green", buttonTextColor: "soft-beige"),
    OnboardingModel(title: "Résous des énigmes", text: "Chaque rêve est rempli de secrets. Observe, fouille, utilise tes outils et dévoile des indices cachés. Résous des énigmes pour révéler la face cachée des songes.", icone: "icon-eye", backgroundColor: "sof-green", textColor: "soft-beige", buttonColor: "soft-pink", buttonTextColor: "dream-black"),
    OnboardingModel(title: "Choisis ta voie", text: "À chaque étape, tes choix façonnent ton parcours. Que décides-tu ? Avancer dans l’ombre ou percer les mystères ? Chaque décision révèle une part de toi.", icone: "icon-path", backgroundColor: "primary-beige", textColor: "mid-green", buttonColor: "mid-green", buttonTextColor: "soft-beige"),
    OnboardingModel(title: "Récolte des artefacts", text: "À la fin de chaque rêve, remporte un artefact : un fragment de ta personnalité. Ton exploration et tes choix déterminent lequel tu emporteras avec toi.", icone: "icon-cards-hands", backgroundColor: "soft-pink", textColor: "dream-black", buttonColor: "mid-green", buttonTextColor: "soft-beige"),
    OnboardingModel(title: "Collectionne-les tous !", text: "Accumule ces précieux fragments et reconstitue petit à petit la mosaïque de ta personnalité. Chaque artefact est unique, tout comme ton chemin.", icone: "icon-cards", backgroundColor: "sof-green", textColor: "soft-beige", buttonColor: "soft-pink", buttonTextColor: "dream-black"),
    OnboardingModel(title: "Découvre ta personnalité", text: "Parcours tes rêves, rassemble tes fragments, et observe ton reflet se construire.", icone: "icon-faces-dark", backgroundColor: "primary-beige", textColor: "mid-green", buttonColor: "mid-green", buttonTextColor: "soft-beige")
]
