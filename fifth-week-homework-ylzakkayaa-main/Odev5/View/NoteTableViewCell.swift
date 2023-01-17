//
//  NoteTableViewCell.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 29.11.2022.
//

import UIKit

final class NoteTableViewCell: UITableViewCell {

    @IBOutlet private weak var noteLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeNameLabel: UILabel!
    
    func configureCell(model: Note) {
        noteLabel.text = ("Note: \(model.noteText ?? "")")
        seasonLabel.text = ("Season: \(model.season ?? "")")
        episodeNameLabel.text = ("Episode: \(model.episode ?? "")")
    }
}
