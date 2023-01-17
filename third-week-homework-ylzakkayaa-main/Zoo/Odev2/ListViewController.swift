//
//  ListViewController.swift
//  Odev2
//
//  Created by Yeliz Akkaya on 19.11.2022.
//

import UIKit
import AVFoundation


final class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet private weak var listTableView: UITableView!
    var itemsCaregiver: [Caregiver] = []
    var itemsAnimal: [AnimalsInfo] = []
    var itemSearchCaregiver : [Caregiver] = []
    var items: [[Any]]?
    var chosenAnimal: AnimalsInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = [itemsAnimal,itemsCaregiver]
        listTableView.delegate = self
        listTableView.dataSource = self
        
        listTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemTableViewCell")
        listTableView.register(UINib(nibName: "CaregiverTableViewCell", bundle: nil), forCellReuseIdentifier: "CaregiverTableViewCell")
        
        itemSearchCaregiver = itemsCaregiver
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Name to search"
        navigationItem.searchController = search
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Animal"
        }else{
            return "Caregiver"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items!.count // 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (items?[section].count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            //Animal render.
            let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
            let animal = items![indexPath.section][indexPath.row] as? AnimalsInfo
            cell.configure(with: animal!)
            return cell
        }
        else {
            //Caregiver render.
            let cell = tableView.dequeueReusableCell(withIdentifier: "CaregiverTableViewCell", for: indexPath) as! CaregiverTableViewCell
            let caregiver = items![indexPath.section][indexPath.row] as? Caregiver
            cell.configure(with: caregiver!)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let animal = items![indexPath.section][indexPath.row] as? AnimalsInfo
            animal?.speak()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        itemsCaregiver = itemSearchCaregiver.filter({ $0.name.contains(text) })
        print(itemsCaregiver)
        if text == "" {
            itemsCaregiver = itemSearchCaregiver
        }
        listTableView.reloadData()
    }
}
