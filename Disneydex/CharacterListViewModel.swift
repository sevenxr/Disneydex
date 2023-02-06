//
//  CharacterListViewModel.swift
//  Disneydex
//
//  Created by Miguel Diaz on 2/5/23.
//

import Foundation

class CharacterListViewModel {
    private static let initialUrl = URL(string: "https://api.disneyapi.dev/characters")!
    
    var characterList: [DisneyCharacter] = []
    
    var lastGetCharactersApiResponse: GetCharactersApiResponse?
    var disneyDataService: DisneyDataService = DisneyDataService()
    var onUpdate: (() -> Void)?
    
    var nextUrl: URL? {
        guard let lastGetCharactersApiResponse = lastGetCharactersApiResponse
        else {
            return Self.initialUrl
        }
        
        return lastGetCharactersApiResponse.nextPage
    }
    
    func getNextPage() {
        guard let url = nextUrl
        else {
            onUpdate?()
            return
        }
        
        disneyDataService.executeRequest(withUrl: url) { [weak self] (response: GetCharactersApiResponse?) in
            if let characters = response?.data {
                self?.characterList.append(contentsOf: characters)
            }
            self?.onUpdate?()
        }
    }
}
