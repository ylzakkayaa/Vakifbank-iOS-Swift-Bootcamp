//
//  CharacterViewController.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 25.11.2022.
//

//Karakter detayını gösteren viewcontroller.

import UIKit
import SDWebImage

class CharacterViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    var character: CharacterModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "Name: \(character?.name ?? "")"
        birthdayLabel.text = "Birthday: \(character?.birthday ?? "")"
        nicknameLabel.text = "Nickname: \(character?.nickname ?? "")"
        statusLabel.text = "Status: \(character?.liveStatus ?? "")"
        photo.sd_setImage(with: URL(string: character!.photoUrl),placeholderImage: UIImage(named: "noimage"),options: .continueInBackground)
    }
    
    //Butona tıklayınca karakterin cümlelerini getiriyor.
    @IBAction func quotesButton(_ sender: Any) {
        performSegue(withIdentifier: "toQuotes", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuotes" {
            let destinationVC = segue.destination as! QuotesViewController
            destinationVC.characterName = character
        }
    }
}
