//
//  DisneyCharacterListCellPresenter.swift
//  Disneydex
//
//  Created by Miguel Diaz on 2/6/23.
//

import UIKit

struct DisneyCharacterListCellPresenter {
    var disneyCharacter: DisneyCharacter
    
    var nameLabel: UILabel?
    var imageView: UIImageView?
    
    func present() {
        nameLabel?.text = disneyCharacter.name
        imageView?.image = nil
        
        fetchImage(url: disneyCharacter.imageUrl)
    }
    
    func fetchImage(url: URL) {
        let imageView = imageView
        ImageFetcher.shared.image(url: url) { image in
            imageView?.image = image
        }
    }
}
