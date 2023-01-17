//
//  AddNotesViewController.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 1.12.2022.
//

import UIKit

protocol NewNoteDelegate: AnyObject {
    func savePressed(input: String, season: String, episode: String)
    func updatePressed(previousText: String, currentText: String, season: String, episode: String)
}

final class AddNotesViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var selectedNote: Note?
    var selectedNoteTrueOrFalse = false
    
    var allEpisodesArray: [[String]] = [[]]
    var episodesArray: [String] {
        return allEpisodesArray[selectedSeasonRow]
    }
    var seasonsArray: [String] = []
    var selectedEpisodeRow: Int = 0
    var selectedSeasonRow: Int = 0

    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var episodeLabel: UILabel!
    
    @IBOutlet weak var addNotesText: UITextField!
    @IBOutlet weak var seasonsPicker: UIPickerView!
    @IBOutlet weak var episodesPicker: UIPickerView!
    @IBOutlet weak var addOrUpdateButtonOutlet: UIButton!
    weak var delegate: NewNoteDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addOrUpdateButtonOutlet.setTitle("Add", for: .normal)
        
        seasonsPicker?.delegate = self
        seasonsPicker?.dataSource = self
        
        episodesPicker?.delegate = self
        episodesPicker?.dataSource = self
        
        indicator.startAnimating()
        Client.getEpisodes { [weak self] allEpisodes, error in
            guard let self = self else { return }
            self.seasonsArray = (allEpisodes?.map { $0.seasons.trimmingCharacters(in: .whitespacesAndNewlines)})!.unique //Dönen responsetan bütün sezonları alıyor ve bunları unique hale getiriyorum.

            for season in self.seasonsArray {
                let episodeNames = allEpisodes?.filter {$0.seasons.trimmingCharacters(in: .whitespacesAndNewlines) == season}.map{$0.episodesName} //Her sezonun episode name'lerini alıyorum ve aşağıdaki arraye atıyorum.
                self.allEpisodesArray.append(episodeNames!)
            }
            self.seasonsPicker.reloadAllComponents() //Response geç döndüğü için döndükten sonra picker'ı reload ediyorum.
            self.indicator.stopAnimating()

        }

        seasonLabel.text = selectedNote?.season
        episodeLabel.text = selectedNote?.episode
        addNotesText.text = selectedNote?.noteText
        seasonsPicker.selectedRow(inComponent: 0)
        episodesPicker.selectedRow(inComponent: 0)
        
        if (addNotesText.text != "") {
            selectedNoteTrueOrFalse = true
            addOrUpdateButtonOutlet.setTitle("Update", for: .normal)
        }
    }
    
    @IBAction func addOrUpdateButton(_ sender: Any) {
        if selectedNoteTrueOrFalse == true {
            if selectedNote?.noteText == addNotesText.text {
                self.showErrorAlert(message: "No changes note.") {
                }
            } else {
            delegate?.updatePressed(previousText: (selectedNote?.noteText)!, currentText: addNotesText.text ?? "", season: seasonLabel.text ?? "", episode: episodeLabel.text ?? "")
            dismiss(animated: true, completion: nil)
            }
        } else {
            if (seasonLabel.text == "" || episodeLabel.text == "" || addNotesText.text == "") {
                self.showErrorAlert(message: "Not all values ​​selected.") {
                }
            } else {
            delegate?.savePressed(input: addNotesText.text!, season: seasonLabel.text ?? "", episode: episodeLabel.text ?? "")
            dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == seasonsPicker {
            return seasonsArray.count
        } else {
            return episodesArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == seasonsPicker {
            return seasonsArray[row]
        } else {
            return episodesArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == seasonsPicker {
            seasonLabel.text = seasonsArray[row]
            selectedSeasonRow = row + 1
            self.episodesPicker.reloadAllComponents() //Seçilen sezona göre bölümlerin gelmesi için picker'ı reload eliyorum.
        } else {
            episodeLabel.text = (episodesArray[row])
            selectedEpisodeRow = row
        }
    }
}

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
