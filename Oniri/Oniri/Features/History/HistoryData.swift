////
////  HistoryData.swift
////  Oniri
////
////  Created by Arnaud Hayon on 27/07/2025.
////
//
//import Foundation
//
//// Structures pour représenter les données JSON
//struct HistoryData: Codable {
//    let histories: [History]
//    let questions: [Question]
//    let choices: [Choice]
//}
//
//struct History: Codable {
//    let id: String
//    let title: String
//    let subtitle: String
//    let narrative: [String]
//    let imageName: ImageName?
//    let questionId: Int?
//    let type: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, title, subtitle, narrative, type
//        case imageName = "image_name"
//        case questionId = "question_id"
//    }
//}
//
//struct ImageName: Codable {
//    let start: String?
//    let end: String?
//}
//
//struct Question: Codable {
//    let id: Int
//    let text: String
//}
//
//struct Choice: Codable {
//    let id: Int
//    let text: String
//    let destination: String
//    let trait: String
//}
