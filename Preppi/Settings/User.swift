//
//  User.swift
//  Preppi
//
//  Created by Степан Величко on 30.01.2023.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let name: String
    let email: String
}
