//
//  ViewController.swift
//  Disneydex
//
//  Created by Miguel Diaz on 2/5/23.
//

import UIKit

class ViewController: UIViewController {
    var viewModel: CharacterListViewModel = CharacterListViewModel()
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = .init(width: 300, height: 40)
        collectionView = UICollectionView(frame: self.view.frame,
                                          collectionViewLayout: flowLayout)
        collectionView.register(SimpleDisneyCharacterListCell.self,
                                forCellWithReuseIdentifier: SimpleDisneyCharacterListCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
        
        //kicks off the first fetch
        viewModel.getNextPage()
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(viewModel.characterList[indexPath.row])
    }
}

//extending ViewController instead of CharacterListViewModel due to NSObjectProtocol requirement
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimpleDisneyCharacterListCell.reuseIdentifier, for: indexPath) as! SimpleDisneyCharacterListCell
        
        let idx = indexPath.row
        cell.nameLabel.text = viewModel.characterList[idx].name
        return cell
    }
}

class SimpleDisneyCharacterListCell: UICollectionViewCell {
    static let reuseIdentifier = "simple-character-list-cell-identifier"
    var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 18)
            label.textColor = .darkText
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        addSubview(nameLabel)
        
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) unimplemented")
    }
}

