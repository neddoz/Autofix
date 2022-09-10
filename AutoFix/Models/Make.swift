//
//  Make.swift
//  AutoFix
//
//  Created by kayeli dennis on 10/09/2022.
//

// MARK: - MakeList
struct Makes: Codable {
    let makeList: [Make]
    let pagination: Pagination
}

// MARK: - Make
struct Make: Codable {
    let id: Int
    let name: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
    }
}
