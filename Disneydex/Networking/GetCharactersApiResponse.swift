//
//  GetCharactersApiResponse.swift
//  Disneydex
//
//  Created by Miguel Diaz on 2/5/23.
//

import Foundation

struct GetCharactersApiResponse {
    var data: [DisneyCharacter]
    var count: Int
    var totalPages: Int
    var nextPage: URL?
}

extension GetCharactersApiResponse: Decodable {}
