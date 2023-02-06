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
        flowLayout.itemSize = .init(width: 300, height: 296)
        collectionView = UICollectionView(frame: self.view.frame,
                                          collectionViewLayout: flowLayout)
        collectionView.register(DisneyCharacterListCell.self,
                                forCellWithReuseIdentifier: DisneyCharacterListCell.reuseIdentifier)
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DisneyCharacterListCell.reuseIdentifier, for: indexPath) as! DisneyCharacterListCell
        
        let disneyCharacter = viewModel.characterList[indexPath.row]
        let presenter = DisneyCharacterListCellPresenter(disneyCharacter: disneyCharacter)
        cell.presenter = presenter
        
        return cell
    }
}
