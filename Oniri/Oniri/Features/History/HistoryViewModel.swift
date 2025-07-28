//
//  HistoryViewModel.swift
//  Oniri
//
//  Created by Arnaud Hayon on 25/07/2025.
//

import Foundation
import SwiftUI

@Observable
class HistoryViewModel {
    
    var historyIndex: Int = 0
    
    var currentHistory: History {
        return histories[historyIndex]
    }
    
       let historyMappings: [Int: [Int: Int]] = [
           0: [0: 1, 1: 2],
           1: [0: 3, 1: 4],
           2: [0: 5, 1: 6],
           3: [0: 7, 1: 8],
           4: [0: 9, 1: 10],
           5: [0: 11, 1: 12],
           6: [0: 13, 1: 14]
       ] 

       func updateCurrentHistory(answerIndex: Int) {
           if let mappings = historyMappings[historyIndex] {
               if let newIndex = mappings[answerIndex] {
                   historyIndex = newIndex
               }
           }
       }
    
}
