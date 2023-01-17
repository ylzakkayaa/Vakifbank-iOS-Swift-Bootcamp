//
//  ViewController.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 23.11.2022.
//
//Uygulama çalıştığında ilk açılan ekran.

import UIKit

final class CharactersListViewController: BaseViewController {
    
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    var selectedCharacter: CharacterModel?
    
    private var character: [CharacterModel]? {
        didSet {
            charactersCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        indicator.startAnimating()
        Client.getCharacters { [weak self] allCharacters, error in
            guard let self = self else { return }
            self.indicator.stopAnimating()
            self.character = allCharacters
        }
        
        //Grid yapısında olması için layout ekledim. Üstten ve soldan boşluklar ekledim.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 40
        layout.minimumInteritemSpacing = 40
        charactersCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    //Cell'leri configure ettim.
    private func configureTableView() {
        charactersCollectionView.dataSource = self
        charactersCollectionView.delegate = self
        charactersCollectionView.register(UINib(nibName: "CharactersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "charactersCell")
    }
}

extension CharactersListViewController:  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        character?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "charactersCell", for: indexPath) as? CharactersCollectionViewCell,
              let model = character?[indexPath.row]
        else {
            return UICollectionViewCell()
        }
        cell.configureCell(model: model)
        return cell
    }
    
    //Her bir item'ın sağdan soldan, aşağıdan ve yukarıdan ne kadar boşluk olması gerektiğini belirledim.
    func collectionView(_ charactersCollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50.0, left: 10.0, bottom: 50.0, right: 10.0)
    }

    //Her bir item'ın boyunu belirledim. Her bir satırda bir item görünsün dedim.
    func collectionView(_ charactersCollectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = charactersCollectionView.frame.width / 1 - gridLayout.minimumInteritemSpacing
        return CGSize(width:widthPerItem, height:100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCharacter = character?[indexPath.row]
        performSegue(withIdentifier: "toCharacter", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCharacter" {
            let destinationVC = segue.destination as! CharacterViewController
            destinationVC.character = selectedCharacter
        }
    }
}

