//
//  AddWorkerViewController.swift
//  Odev1
//
//  Created by Yeliz Akkaya on 15.11.2022.
//

import UIKit

final class AddWorkerViewController: UIViewController {

    @IBOutlet private weak var workerNameLabel: UITextField!
    @IBOutlet private weak var workerAgeLabel: UITextField!
    @IBOutlet private weak var workerLevelLabel: UITextField!
    @IBOutlet private weak var salaryLabel: UILabel!
    
    var company: Company?
    var worker: Worker?
    var workerAgeText: Int = 0
    var workerNameText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workerNameLabel.text = ""
        workerAgeLabel.text = String()
        workerLevelLabel.text = ""
    }
    
    @IBAction private func salaryCalculation(_ sender: Any) {
        if let workerAge = Int((workerAgeLabel?.text)!) {
            workerAgeText = workerAge
        }
        
        if let workerName = workerNameLabel?.text {
            workerNameText = workerName
        }
        
        let workerLevelSelect = workerLevelLabel.text
        var control = false
        
        for type in WorkerType.allCases {
            print(type)
            if (type == WorkerType(rawValue: workerLevelSelect!) && control == false) {
                print(type)
                print("Girilen değerler eşleşti")
                control = true
            }
        }
        
        if workerNameText == "" || workerAgeText <= 0 {
            makeAlert(titleInput: "Incorrect Entry", messageInput: "You can enter name, age or level.")
        } else {
            worker = Worker(workerName: workerNameText, workerAge: workerAgeText, type: WorkerType(rawValue: workerLevelSelect!) ?? .defaulttype)
            salaryLabel.text = "Salary: \(worker!.salary)"
        }
        
        if control == false {
            makeAlert(titleInput: "Incorrect Worker Level Entry", messageInput: "You can enter jr, mid or sr.")
        }
    }
    
    @IBAction private func addWorkerToCompany(_ sender: Any) {
        if let workerAge = Int((workerAgeLabel?.text)!) {
            workerAgeText = workerAge
        }
        
        if let workerName = workerNameLabel?.text {
            workerNameText = workerName
        }
        
        let workerLevelSelect = workerLevelLabel.text
        var control = false
        
        for type in WorkerType.allCases {
            print(type)
            if (type == WorkerType(rawValue: workerLevelSelect!) && control == false) {
                print(type)
                print("Girilen değerler eşleşti")
                control = true
            }
        }
        
        if workerNameText == "" || workerAgeText <= 0 {
            makeAlert(titleInput: "Incorrect Entry", messageInput: "You can enter name, age or level.")
        } else if control == false {
            makeAlert(titleInput: "Incorrect Entry", messageInput: "You can enter jr, mid or sr.")
        } else {
            worker = Worker(workerName: workerNameText, workerAge: workerAgeText, type: WorkerType(rawValue: workerLevelSelect!) ?? .defaulttype)
        }
        
        if worker?.workerName == nil {
            makeAlert(titleInput: "Incorrect Worker Entry", messageInput: "You can enter worker.")
        } else {
            company?.addWorker(worker: worker!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func makeAlert(titleInput: String, messageInput:String)  {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

//Çalışan tiplerini burada belirledim ve maaş ödemesindeki katsayıları buna göre verdim.
enum WorkerType: String, CaseIterable {
    case jr
    case mid
    case sr
    case defaulttype
    
    var salaryCoef : Int {
        switch self {
        case .jr:
            return 1
        case .mid:
            return 2
        case .sr:
            return 3
        case .defaulttype:
            return 0
        }
    }
}

//Worker struckt'ının protocolünü tanımladım.
protocol WorkerInfo {
    var workerName: String { get }
    var workerSurname: String? { get }
    var workerAge: Int { get }
    var workerMaritalStatus: String? { get }
    var type: WorkerType { get }
    var salary : Int { get }
}

//Çalışan sınıfı.
class Worker: WorkerInfo {
    var workerName: String
    var workerSurname: String?
    var workerAge: Int
    var workerMaritalStatus: String?
    var type : WorkerType //Burada type'ın tipini yukarıda tanımladığım enum'dan aldım.
    var salary: Int {
        1000 * type.salaryCoef * Int(workerAge) //Maaş ödemesinin nasıl yapılacağını belirledim.
    }
    
    init(workerName: String, workerAge: Int, type: WorkerType) {
        self.workerName = workerName
        self.workerAge = workerAge
        self.type = type
    }
}
