//
//  ItemTableViewCell.swift
//  Odev2
//
//  Created by Yeliz Akkaya on 19.11.2022.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var caregiverNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with modal: AnimalsInfo) {
        nameLabel.text = modal.name
        caregiverNameLabel.text = modal.careGiver?.name ?? "Not assigned."
    }
    
}
