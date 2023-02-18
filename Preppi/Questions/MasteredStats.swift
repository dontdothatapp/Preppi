//
//  MasteredStats.swift
//  Preppi
//
//  Created by Степан Величко on 08.02.2023.
//

import Foundation

struct Stats: Identifiable, Hashable {
    var id: String
    var category: String
    var mastered: Int
    var total: Int
}
