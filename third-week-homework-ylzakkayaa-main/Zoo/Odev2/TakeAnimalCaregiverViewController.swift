//
//  TakeAnimalCaregiverViewController.swift
//  Odev2
//
//  Created by Yeliz Akkaya on 19.11.2022.
//

import UIKit

final class TakeAnimalCaregiverViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet private weak var animalLabel: UILabel!
    @IBOutlet private weak var animalPicker: UIPickerView!
    @IBOutlet private weak var caregiverPicker: UIPickerView!
    @IBOutlet private weak var caregiverLabel: UILabel!
    
    var zoo: Zoo?
    var animals: [AnimalsInfo]?
    var caregivers: [Caregiver]?
    var selectedCaregiver: [String] = []
    var selectedAnimal: [String] = []
    var selectedCaregiverRow: Int = 0
    var selectedAnimalRow: Int = 0
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalLabel.text = "Animal Selected"
        caregiverLabel.text = "Caregiver Selected"
        
        caregiverPicker.delegate = self
        caregiverPicker.dataSource = self
        animalPicker.delegate = self
        animalPicker.dataSource = self
        
        for caregiverName in caregivers! {
            selectedCaregiver.append(caregiverName.name)
        }
        
        for animalName in animals! {
            selectedAnimal.append(animalName.name)
        }
        
        caregiverLabel.text = selectedCaregiver[0]
        animalLabel.text = selectedAnimal[0]
        
    }
    
    
    @IBAction private func addZooAnimalCaregiver(_ sender: Any) {
        var selectedCaregiverObject = caregivers![selectedCaregiverRow]
        var selectedAnimalObject = animals![selectedAnimalRow]
        print(selectedCaregiverObject.name)
        print(selectedAnimalObject.name)
        
        zoo?.takeAnimalOrCaregiver(animal: &selectedAnimalObject, caregiver: &selectedCaregiverObject, completion: { animal in
            navigationController?.popViewController(animated: true)
        }, onFailure: { error in
            makeAlert(titleInput: "Warning!", messageInput: "You can not zoo")
        })
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == caregiverPicker {
            return selectedCaregiver.count
        } else {
            return selectedAnimal.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == caregiverPicker {
            return selectedCaregiver[row]
        } else {
            return selectedAnimal[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == caregiverPicker {
            caregiverLabel.text = selectedCaregiver[row]
            selectedCaregiverRow = row
        } else {
            animalLabel.text = selectedAnimal[row]
            selectedAnimalRow = row
        }
    }
    
    func makeAlert(titleInput: String, messageInput:String)  {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
