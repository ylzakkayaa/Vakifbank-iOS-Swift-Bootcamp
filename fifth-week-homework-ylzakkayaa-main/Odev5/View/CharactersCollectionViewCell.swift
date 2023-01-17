//
//  CharactersCollectionViewCell.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 24.11.2022.
//

import UIKit

//Bütün karakterleri gösterecek olan collection view celleri oluşturdum.
class CharactersCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var characterBirthdayLabel: UILabel!
    @IBOutlet private weak var characterNicknameLabel: UILabel!
    @IBOutlet weak var characterPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .random
    }
    
    //Celleri configure ettim.
    func configureCell(model: CharacterModel) {
        characterNameLabel.text = "Name: \(model.name)"
        characterBirthdayLabel.text = "Birthday: \(model.birthday)"
        characterNicknameLabel.text = "Nickname: \(model.nickname)"
        characterPhoto.sd_setImage(with: URL(string: model.photoUrl),placeholderImage: UIImage(named: "noimage"),options: .continueInBackground)
    }

}

//Random color oluşturması için extension tanımladım.
extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

