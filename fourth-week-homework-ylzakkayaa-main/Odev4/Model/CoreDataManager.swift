//
//  CoreDataManager.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 28.11.2022.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate.persistentContainer.viewContext
    }
    
    //Yazılan notları kaydetmek için kullanacağız.
    func saveNote(text: String, season: String, episode: String) -> Note? {
        //CoreDatadaki note'a erişiyorum.
        let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext)!
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        //Entityden olan bir obje oluşturuyorum ve buna text'i setliyorum.
        note.setValue(text, forKey: "noteText")
        note.setValue(episode, forKey: "episode")
        note.setValue(season, forKey: "season")
        do {
            try managedContext.save()
            return note as? Note
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    //İçerideki note arrayini alabilmek için fonksiyon yazdım.
    func getNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        do {
            let notes = try managedContext.fetch(fetchRequest)
            return notes as! [Note]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    //İçerideki notlardan silmek için.
    func deleteNote(note: Note) {
        managedContext.delete(note)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    //İçerideki notlardan update etmek için.
    func updateNote(previousText: String, currentText: String, season: String, episode: String) -> Bool{
        var success = false
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return success }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "noteText = %@", previousText) //Requestte gelen önceki text'e göre cora datada arama yapıyorum.
        do {
            let test = try managedContext.fetch(fetchRequest)
            if test.count == 1 {
                let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue(currentText, forKey: "noteText") //Yeni gelen texte göre update işlemini yapıyorum.
                objectUpdate.setValue(episode, forKey: "episode")
                objectUpdate.setValue(season, forKey: "season")
                appDelegate.saveContext() // look in AppDelegate.swift for this function
                success = true
            }
        } catch {
            print(error)
        }
        return success
    }
}
