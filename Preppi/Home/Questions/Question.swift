//
//  Question.swift
//  Preppi
//
//  Created by Степан Величко on 31.01.2023.
//

import Foundation

struct Question: Identifiable, Hashable {
    var id: String
    var category: String
    var question: String
    var type: String
    var timestamp: Date
}
