//
//  ListWorkerViewController.swift
//  Odev1
//
//  Created by Yeliz Akkaya on 15.11.2022.
//

import UIKit

final class ListWorkerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet private weak var workerListTableView: UITableView!
    var items: [Worker] = []
    var itemSearch : [Worker] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        workerListTableView.delegate = self
        workerListTableView.dataSource = self
        
        workerListTableView.register(UINib(nibName: "ItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ItemCell")
        
        itemSearch = items
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Name to search"
        navigationItem.searchController = search
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        cell.nameLabel.text = items[indexPath.row].workerName
        cell.salaryLabel.text = items[indexPath.row].type.rawValue
        return cell
    }

}

extension ListWorkerViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        items = itemSearch.filter({ $0.workerName.contains(text) })
        print(items)
        if text == "" {
            items = itemSearch
        }
        workerListTableView.reloadData()
    }
}
