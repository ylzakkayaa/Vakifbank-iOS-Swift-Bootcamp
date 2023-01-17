//
//  ViewController.swift
//  Odev2
//
//  Created by Yeliz Akkaya on 18.11.2022.
//

import UIKit

final class ViewController: UIViewController {

    var zoo: Zoo?
    
    @IBOutlet private weak var zooNameLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!
    @IBOutlet private weak var waterLimitLabel: UILabel!
    @IBOutlet private weak var incomeOrExpenseText: UITextField!
    @IBOutlet private weak var addWaterLimitText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zoo = Zoo(budget: 1000000, waterLimit: 500, animals: [], caregivers: [])
        budgetLabel?.text! = "Budget: \(zoo!.budget)"
        waterLimitLabel?.text! = "Water Limit: \(zoo!.waterLimit)"
    }

    @IBAction private func incomeButton(_ sender: Any) {
        if incomeOrExpenseText.text == "" {
            makeAlert(titleInput: "Incorrect Entry", messageInput: "Income cannot be empty.")
        } else {
            if let income = Int(incomeOrExpenseText.text!){
                if income < 0 {
                    makeAlert(titleInput: "Incorrect Entry", messageInput: "Amount can not be negative.")
                } else {
                    zoo!.budget += income
                    budgetLabel?.text! = "Budget: \(zoo!.budget)"
                }
            }
        }
    }
    
    @IBAction private func expenseButton(_ sender: Any) {
        if incomeOrExpenseText.text == "" {
            makeAlert(titleInput: "Incorrect Entry", messageInput: "Expense cannot be empty.")
        } else {
            if let expense = Int(incomeOrExpenseText.text!){
                if expense < 0 {
                    makeAlert(titleInput: "Incorrect Entry", messageInput: "Amount can not be negative.")
                } else {
                    zoo!.budget -= expense
                    budgetLabel?.text! = "Budget: \(zoo!.budget)"
                }
            }
        }
    }
    
    @IBAction private func addWaterLimitButton(_ sender: Any) {
        if addWaterLimitText.text == "" {
            makeAlert(titleInput: "Incorrect Entry", messageInput: "Expense cannot be empty.")
        } else {
            if let addWater = Int(addWaterLimitText.text!){
                if addWater < 0 {
                    makeAlert(titleInput: "Incorrect Entry", messageInput: "Amount can not be negative.")
                } else {
                    zoo!.waterLimit += addWater
                    waterLimitLabel?.text! = "Water Limit: \(zoo!.waterLimit)"
                }
            }
        }
    }
    
    @IBAction private func substractionWaterLimitButton(_ sender: Any) {
        if addWaterLimitText.text == "" {
            makeAlert(titleInput: "Incorrect Entry", messageInput: "Expense cannot be empty.")
        } else {
            if let addWater = Int(addWaterLimitText.text!){
                if addWater < 0 {
                    makeAlert(titleInput: "Incorrect Entry", messageInput: "Amount can not be negative.")
                } else {
                    zoo!.waterLimit -= addWater
                    waterLimitLabel?.text! = "Water Limit: \(zoo!.waterLimit)"
                }
            }
        }
    }
    
    @IBAction private func takeAnimalOrCaregiverButton(_ sender: Any) {
        if (zoo?.caregivers.count)! > 0 && (zoo?.animals.count)! > 0 {
            performSegue(withIdentifier: "toTakeAnimalCaregiver", sender: nil)
        } else {
            makeAlert(titleInput: "Empty Caregiver or Animal", messageInput: "Caregiver or Animal can not be empty.")
        }
    }
    
    @IBAction private func addCaregiver(_ sender: Any) {
        performSegue(withIdentifier: "toAddCaregiver", sender: nil)
    }
    
    @IBAction private func addAnimal(_ sender: Any) {
        performSegue(withIdentifier: "toAddAnimal", sender: nil)
    }
    
    @IBAction private func listAnimal(_ sender: Any) {
        performSegue(withIdentifier: "toList", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddCaregiver" {
            let destinationVC = segue.destination as! AddCaregiverViewController
            destinationVC.zoo = self.zoo
        }
        
        if segue.identifier == "toAddAnimal" {
            let destinationVC = segue.destination as! AddAnimalViewController
            destinationVC.zoo = self.zoo
        }
        
        if segue.identifier == "toTakeAnimalCaregiver" {
            let destinationVC = segue.destination as! TakeAnimalCaregiverViewController
            destinationVC.animals = self.zoo!.animals
            destinationVC.caregivers = self.zoo!.caregivers
            destinationVC.zoo = self.zoo!
        }
        
        if segue.identifier == "toList" {
            let destinationVC = segue.destination as! ListViewController
            destinationVC.itemsCaregiver = self.zoo!.caregivers
            destinationVC.itemsAnimal = self.zoo!.animals
        }
    }
    
    @IBAction private func paySalaryButton(_ sender: Any) {
        zoo?.paySalary(completion: { budget in
            budgetLabel.text = "Budget: \(zoo!.budget)"
        }, onFailure: { error in
            makeAlert(titleInput: "Not Enough Money", messageInput: "Not enough money to pay salary.")
        })
    }
    
    func makeAlert(titleInput: String, messageInput:String)  {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}


//Zoo clasının protocolü tanımlandı.
protocol ZooInfo {
    var budget: Int { get }
    var waterLimit: Int { get }
    var animals: [any AnimalsInfo] { get }
    var caregivers: [Caregiver] { get }
    var totalSalary: Int { get }
}

class Zoo: ZooInfo {
    var budget: Int
    var waterLimit: Int
    var animals: [any AnimalsInfo] //Eklenecek olan animal AnimalsInfo protocolüne uygun olmalı.
    var caregivers: [Caregiver] //Eklenecek olan bakıcı Caregiver classından olmalı.
    var totalSalary: Int { //Tüm bakıcıların maaşı hesaplandı, toplam maaş dönüyorum.
        var totalWorkerSalary: Int = 0
        for workerSalary in caregivers {
            totalWorkerSalary += workerSalary.salary
        }
        return totalWorkerSalary
    }
    
    init(budget: Int, waterLimit: Int, animals: [AnimalsInfo], caregivers: [Caregiver]) {
        self.waterLimit = waterLimit
        self.budget = budget
        self.animals = animals
        self.caregivers = caregivers
    }
    
    //Hayvan eklemesi yapıyorum. AnimalsInfo protocolüne uygun bir veri bekliyorum. Başarılı olursa eklenen hayvanı dönüyorum.
    func addAnimal(animal: AnimalsInfo, completion: (_ animal: AnimalsInfo) -> Void, onFailure: (_ error: String) -> Void) {
        guard animal.waterLimit <= waterLimit
        else {
            onFailure("Not enough water limit to add new animal.")
            return
        }
        animals.append(animal)
        waterLimit -= animal.waterLimit
        completion(animal)
    }
    
    //Gelir eklemesi yapıyorum. Eklenecek gelirin fonksiyon çağrıldığında gelmesini bekliyorum, completion'da bütçeyi dönüyorum.
    func addIncome (amount income: Int, completion: (_ budget: Int) -> Void, onFailure: (_ error: String) -> Void) {
        guard income > 0
        else {
            onFailure("Amount can not be negative.")
            return
        }
        budget += income
        completion(budget)
    }
    
    //Gider çıkarma kısmını yapıyorum. Çıkarılacak gelirin fonksiyon çağrıldığında gelmesini bekliyorum, completion'da bütçeyi dönüyorum.
    func incomeComesOut (amount expense: Int, completion: (_ budget: Int) -> Void, onFailure: (_ error: String) -> Void) {
        guard expense > 0
        else {
            onFailure("Amount can not be negative.")
            return
        }
        
        guard expense <= budget
        else {
            onFailure("Not enough money to add expense.")
            return
        }
        budget -= expense
        completion(budget)
    }
    
    //Su eklemeyi yapıyorum. Girdi olarak eklenecek su miktarını bekliyorum.
    func addWater (amount water: Int, completion: (_ waterLimit: Int) -> Void, onFailure: (_ error: String) -> Void) {
        guard water > 0
        else {
            onFailure("Amount can not be negative.")
            return
        }
        waterLimit += water
        completion(waterLimit)
    }
    
    //Maaş ödemesi yapıyorum. completion'da bütçeyi dönüyorum.
    func paySalary(completion: (_ budget: Int) -> Void, onFailure: (_ error: String) -> Void) {
        guard totalSalary <= budget
        else {
            onFailure("Not enough money to pay salary.")
            return
        }
        budget -= totalSalary
        completion(budget)
    }
    
    //Bakıcı eklemesi yapıyorum. Girdi olarak Caregiver classından bekliyorum.
    func addCaregiver(caregiver: Caregiver) {
        caregivers.append(caregiver)
    }
    
    func takeAnimalOrCaregiver(animal: inout AnimalsInfo, caregiver: inout Caregiver,completion: (_ animal: AnimalsInfo) -> Void, onFailure: (_ error: String) -> Void){
        guard animals.contains(where: { $0.name == animal.name }) else {
            onFailure("This animal is not exists.")
            return
        }
        guard caregivers.contains(where: { $0.name == caregiver.name }) else {
            onFailure("This caregiver is not exists.")
            return
        }
        guard animal.careGiver == nil else {
            onFailure("This animal has already caregiver")
            return
        }
        animal.careGiver = caregiver
        caregiver.animals?.append(animal)
        completion(animal)
    }

    //Constructorda gelen hayvanların su tüketimini günlük su limitinden düşüyorum.
    //init(budget: Int, waterLimit: Int, animals: [any AnimalsInfo], caregivers: [Caregiver]) {
    //    self.budget = budget
    //    self.animals = animals
    //    self.caregivers = caregivers
    //
    //    var totalAnimalWater: Int = 0
    //    for animal in animals {
    //        totalAnimalWater += animal.waterLimit
    //    }
    //    self.waterLimit = waterLimit - totalAnimalWater
    //}
    
}
