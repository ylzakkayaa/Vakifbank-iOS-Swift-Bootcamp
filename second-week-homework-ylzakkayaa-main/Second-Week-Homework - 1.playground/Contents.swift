import Foundation

//Çalışan tiplerini burada belirledim ve maaş ödemesindeki katsayıları buna göre verdim.
enum WorkerType {
    case jr
    case mid
    case sr
    
    var salaryCoef : Double {
        switch self {
        case .jr:
            return 1.5
        case .mid:
            return 2
        case .sr:
            return 2.5
        }
    }
}

//Worker struckt'ının protocolünü tanımladım.
protocol WorkerInfo {
    var workerName: String { get }
    var workerSurname: String? { get }
    var workerAge: Int { get }
    var workerMaritalStatus: String { get }
    var type: WorkerType { get }
    var salary : Double { get }
}

//Çalışan sınıfı.
struct Worker: WorkerInfo {
    var workerName: String
    var workerSurname: String?
    var workerAge: Int
    var workerMaritalStatus: String
    var type : WorkerType //Burada type'ın tipini yukarıda tanımladığım enum'dan aldım.
    var salary: Double {
        1000 * type.salaryCoef * Double(workerAge) //Maaş ödemesinin nasıl yapılacağını belirledim.
    }
}

//Şirket struct'ının protocolünü tanımladım.
protocol CompanyInfo {
    var companyName: String { get }
    var foundationYear: Int { get }
    var budget: Double { get }
    var workerArray: [Worker] { get }
    var totalSalary: Double { get }
    mutating func addWorker(worker:Worker)
    mutating func paySalary(completion: (_ budget: Double) -> Void, onFailure: (_ error:String) -> Void)
    mutating func addIncome (amount income: Double, completion: (_ budget: Double) -> Void, onFailure: (_ error: String) -> Void)
    mutating func addExpense (amount expense: Double, completion: (_ budget: Double) -> Void, onFailure: (_ error:String) -> Void)
}

struct Company: CompanyInfo{
    var companyName: String
    var foundationYear: Int
    var budget: Double
    var workerArray: [Worker] //Worker'ı çalışan sınıfından alıyorum.
    var totalSalary: Double { //Çalışanların toplam maaşını hesaplıyorum.
        var totalWorkerSalary: Double = 0.0
        for workerSalary in workerArray {
            totalWorkerSalary += workerSalary.salary
        }
        return totalWorkerSalary
    }
    
    //Çalışan ekliyorum.
    mutating func addWorker(worker: Worker) {
        workerArray.append(worker)
    }
    
    //Maaş ödemesi yapıyorum. completion'da bütçeyi dönüyorum.
    mutating func paySalary(completion: (_ budget: Double) -> Void, onFailure: (_ error: String) -> Void) {
        guard totalSalary <= budget
        else {
            onFailure("Not enough money to pay salary.")
            return
        }
        budget -= totalSalary
        completion(budget)
    }
    
    //Gelir eklemesi yapıyorum. Eklenecek gelirin fonksiyon çağrıldığında gelmesini bekliyorum, completion'da bütçeyi dönüyorum.
    mutating func addIncome (amount income: Double, completion: (_ budget: Double) -> Void, onFailure: (_ error: String) -> Void) {
        guard income > 0
        else {
            onFailure("Amount can not be negative")
            return
        }
        budget += income
        completion(budget)
    }
    
    //Gider çıkarma kısmını yapıyorum. Çıkarılacak gelirin fonksiyon çağrıldığında gelmesini bekliyorum, completion'da bütçeyi dönüyorum.
    mutating func addExpense (amount expense: Double, completion: (_ budget: Double) -> Void, onFailure: (_ error: String) -> Void) {
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

var workerInfo = Worker(workerName: "Yeliz", workerSurname: "Akkaya", workerAge: 23, workerMaritalStatus: "Single", type: .jr)
var company = Company(companyName: "PowerPuffGirls", foundationYear: 1999, budget: 1000, workerArray: [workerInfo])

company.addWorker(worker: Worker(workerName: "Barış", workerSurname: "Akkaya", workerAge: 26, workerMaritalStatus: "Single", type: .mid))
company.addWorker(worker: Worker(workerName: "Yeliz", workerAge: 23, workerMaritalStatus: "Single", type: .jr))

company.addIncome(amount: 1000) { budget in
    print("Remaining budget is  \(budget)")
} onFailure: { error in
    print(error)
}


company.addExpense(amount: 500) { budget in
    print("Remaining budget is  \(budget)")
} onFailure: { error in
    print(error)
}


company.paySalary() { budget in
    print("Remaining budget is  \(budget)")
} onFailure: { error in
    print(error)
}


