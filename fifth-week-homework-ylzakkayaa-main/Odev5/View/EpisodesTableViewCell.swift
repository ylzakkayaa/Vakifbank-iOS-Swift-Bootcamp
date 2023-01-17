//
//  EpisodesTableViewCell.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 26.11.2022.
//

import UIKit

//Bölümleri gösterirken table'ın içine cell oluşturdum. Kaçıncı sezonda olduğunu ve bölümün adını gösteriyorum.
class EpisodesTableViewCell: UITableViewCell {

    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var episodeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureEpisodes(model: EpisodesModel) {
        season.text = "Season: \(model.seasons)"
        episodeName.text = "Episode Name: \(model.episodesName)"
    }
}
