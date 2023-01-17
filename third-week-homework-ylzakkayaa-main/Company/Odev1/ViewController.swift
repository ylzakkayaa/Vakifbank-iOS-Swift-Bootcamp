//
//  ViewController.swift
//  Odev1
//
//  Created by Yeliz Akkaya on 15.11.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    var company : Company?

    @IBOutlet weak var companyInfoLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyFoundationYearLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var incomeOrExpenseText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        company = Company(companyName: "PowerPuffGirlrs", foundationYear: 1999, budget: 100000, workerArray: [])
        companyNameLabel?.text = "\(company!.companyName)"
        companyFoundationYearLabel?.text! = "Foundation Year: \(company!.foundationYear)"
        budgetLabel?.text! = "Budget: \(company!.budget)"
    }

    @IBAction private func paySalary(_ sender: Any) {
        company?.paySalary() { budget in
            print("Remaining budget is  \(budget)")
            budgetLabel?.text! = "Budget: \(company!.budget)"
        } onFailure: { error in
            print(error)
            makeAlert(titleInput: "Not Enough Money", messageInput: "Not enough money to pay salary.")
        }
    }
    
    @IBAction private func addWorker(_ sender: Any) {
        performSegue(withIdentifier: "toAddWorker", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddWorker" {
            
            let destinationVC = segue.destination as! AddWorkerViewController
            destinationVC.company = self.company
        }
        
        if segue.identifier == "toListWorker" {
            let destinationVC = segue.destination as! ListWorkerViewController
            destinationVC.items = self.company!.workerArray
        }
    }
    
    @IBAction private func listWorker(_ sender: Any) {
        performSegue(withIdentifier: "toListWorker", sender: nil)
    }
    
    @IBAction private func income(_ sender: Any) {
        if incomeOrExpenseText.text == "" {
            makeAlert(titleInput: "Incorrect Entry", messageInput: "Income cannot be empty.")
        } else {
            if let income = Int(incomeOrExpenseText.text!){
                if income < 0 {
                    makeAlert(titleInput: "Incorrect Entry", messageInput: "Amount can not be negative.")
                } else {
                    company!.budget += income
                    budgetLabel?.text! = "Budget: \(company!.budget)"
                }
            }
        }
    }
    
    @IBAction private func expense(_ sender: Any) {
        if incomeOrExpenseText.text == "" {
            makeAlert(titleInput: "Incorrect Entry", messageInput: "Expense cannot be empty.")
        } else {
            if let expense = Int(incomeOrExpenseText.text!){
                if expense < 0 {
                    makeAlert(titleInput: "Incorrect Entry", messageInput: "Amount can not be negative.")
                } else {
                    company!.budget -= expense
                    budgetLabel?.text! = "Budget: \(company!.budget)"
                }
            }
        }
    }
    
    func makeAlert(titleInput: String, messageInput:String)  {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

protocol CompanyInfo {
    var companyName: String { get }
    var foundationYear: Int { get }
    var budget: Int { get }
    var workerArray: [Worker] { get }
    var totalSalary: Int { get }
    func addWorker(worker:Worker)
    func paySalary(completion: (_ budget: Int) -> Void, onFailure: (_ error:String) -> Void)
    func addIncome (amount income: Int, completion: (_ budget: Int) -> Void, onFailure: (_ error: String) -> Void)
    func addExpense (amount expense: Int, completion: (_ budget: Int) -> Void, onFailure: (_ error:String) -> Void)
}

class Company: CompanyInfo{
    var companyName: String
    var foundationYear: Int
    var budget: Int
    var workerArray: [Worker] //Worker'ı çalışan sınıfından alıyorum.
    var totalSalary: Int { //Çalışanların toplam maaşını hesaplıyorum.
        var totalWorkerSalary: Int = 0
        for workerSalary in workerArray {
            totalWorkerSalary += workerSalary.salary
        }
        return totalWorkerSalary
    }
    
    init(companyName: String, foundationYear: Int, budget: Int, workerArray: [Worker]) {
        self.companyName = companyName
        self.budget = budget
        self.foundationYear = foundationYear
        self.workerArray = workerArray
    }
    
    //Çalışan ekliyorum.
    func addWorker(worker: Worker) {
        workerArray.append(worker)
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
    
    //Gelir eklemesi yapıyorum. Eklenecek gelirin fonksiyon çağrıldığında gelmesini bekliyorum, completion'da bütçeyi dönüyorum.
    func addIncome (amount income: Int, completion: (_ budget: Int) -> Void, onFailure: (_ error: String) -> Void) {
        guard income > 0
        else {
            onFailure("Amount can not be negative")
            return
        }
        budget += income
        completion(budget)
    }
    
    //Gider çıkarma kısmını yapıyorum. Çıkarılacak gelirin fonksiyon çağrıldığında gelmesini bekliyorum, completion'da bütçeyi dönüyorum.
    func addExpense (amount expense: Int, completion: (_ budget: Int) -> Void, onFailure: (_ error: String) -> Void) {
        guard expense > 0 else {
            onFailure("Amount can not be negative")
            return
        }
        
        guard expense <= budget
        else {
            onFailure("Not enough money to add expense")
            return
        }
        budget -= expense
        completion(budget)
    }
    
}




