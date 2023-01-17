//
//  AddAnimalViewController.swift
//  Odev2
//
//  Created by Yeliz Akkaya on 18.11.2022.
//

import UIKit
import AVFoundation

var catSound: AVAudioPlayer!


final class AddAnimalViewController: UIViewController {

    @IBOutlet private weak var animalNameText: UITextField!
    @IBOutlet private weak var animalWaterLimitText: UITextField!
    @IBOutlet private weak var animalTypeSegmentedControl: UISegmentedControl!
    
    var zoo: Zoo?
    var animal: AnimalsInfo?
    var animalType: AnimalType?
    var animalWaterLimit: Int = 0
    var animalName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animalNameText.text = ""
        animalWaterLimitText.text = String()
    }
    @IBAction private func addAnimalButton(_ sender: Any) {
   
        
        if let name = animalNameText?.text {
            animalName = name
        }
        if let waterLimit = Int((animalWaterLimitText?.text)!) {
            animalWaterLimit = waterLimit
        }
        if let type = AnimalType(rawValue: animalTypeSegmentedControl.selectedSegmentIndex) {
            animalType = type
        }
        
        switch animalType {
        case .cat:
            animal = Cat(waterLimit: animalWaterLimit, name: animalName)
        case .dog:
            animal = Dog(waterLimit: animalWaterLimit, name: animalName)
        case .none:
            makeAlert(titleInput: "Incorrect Entry", messageInput: "You can enter name, water limit or type.")
        }
        
        if animalName == "" || animalWaterLimit <= 0 {
            makeAlert(titleInput: "Incorrect Entry", messageInput: "You can enter name or water limit.")
        } else {
            zoo?.addAnimal(animal: animal!, completion: { animal in
                navigationController?.popViewController(animated: true)
            }, onFailure: { error in
                makeAlert(titleInput: "Error", messageInput: "Animal not added.")
            })
        }
    }
    
    func makeAlert(titleInput: String, messageInput:String)  {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

enum AnimalType: Int, Equatable {
    case cat
    case dog
}

//Hayvan classlarının protocolü tanımlandı.
protocol AnimalsInfo {
    var waterLimit: Int { get }
    var name: String { get }
    var careGiver: Caregiver? { get set }
    func speak()
}


class Cat: AnimalsInfo {
    var waterLimit: Int
    var name: String
    var careGiver: Caregiver?
    func speak(){
        let path = Bundle.main.path(forResource: "cat.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            catSound = try AVAudioPlayer(contentsOf: url)
            catSound?.play()
        } catch {
            print("couldn't load file")
        }
    }
    init(waterLimit: Int, name: String){
        self.waterLimit = waterLimit
        self.name = name
    }
}

class Dog: AnimalsInfo {
    var waterLimit: Int
    var name: String
    
    var careGiver: Caregiver?
    
    func speak(){
        let path = Bundle.main.path(forResource: "dog.mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            catSound = try AVAudioPlayer(contentsOf: url)
            catSound?.play()
        } catch {
            print("couldn't load file")
        }
    }
    init(waterLimit: Int, name: String){
        self.waterLimit = waterLimit
        self.name = name
    }
}
