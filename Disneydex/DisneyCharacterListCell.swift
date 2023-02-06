//
//  DisneyCharacterListCell.swift
//  Disneydex
//
//  Created by Miguel Diaz on 2/6/23.
//

import UIKit

class DisneyCharacterListCell: UICollectionViewCell {
    static let reuseIdentifier = "character-list-cell-identifier"
    var nameLabel: UILabel!
    var imageView: UIImageView!
    
    var presenter: DisneyCharacterListCellPresenter! {
        didSet {
            presenter.nameLabel = nameLabel
            presenter.imageView = imageView
            
            presenter.present()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.textColor = .darkText
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        imageView = {
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, imageView])
        stackView.axis = .vertical
        stackView.frame = frame
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 256).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) unimplemented")
    }
}
