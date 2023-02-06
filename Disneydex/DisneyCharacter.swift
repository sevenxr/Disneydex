//
//  DisneyCharacter.swift
//  Disneydex
//
//  Created by Miguel Diaz on 2/5/23.
//

import Foundation

struct DisneyCharacter {
    var id: Int
    var name: String
    var imageUrl: URL
    var url: URL
    
    var films: [String]
    var shortFilms: [String]
    var tvShows: [String]
    var videoGames: [String]
    var parkAttractions: [String]
    var allies: [String]
    var enemies: [String]
}

extension DisneyCharacter: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, imageUrl, url
        
        case films
        case shortFilms
        case tvShows
        case videoGames
        case parkAttractions
        case allies
        case enemies
    }
}
