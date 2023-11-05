//
//  Films.swift
//  m18_home
//
//  Created by Михаил Ганин on 14.04.2023.
//

import Foundation


// MARK: - Films
struct Films: Codable {
    let searchType, expression: String
    let results: [Result]
    let errorMessage: String
}

// MARK: - Result
struct Result: Codable {
    let id, resultType, image, title: String
    let description: String
}
