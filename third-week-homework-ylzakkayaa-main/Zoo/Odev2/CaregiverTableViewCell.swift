//
//  CaregiverTableViewCell.swift
//  Odev2
//
//  Created by Yeliz Akkaya on 20.11.2022.
//

import UIKit

class CaregiverTableViewCell: UITableViewCell {

    @IBOutlet weak var caregiverExperienceLabel: UILabel!
    @IBOutlet weak var caregiverNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with modal: Caregiver) {
        caregiverExperienceLabel.text = "\(modal.experiance)"
        caregiverNameLabel.text = "\(modal.name)"
    }
    
}
