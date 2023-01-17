//
//  QuotesViewController.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 26.11.2022.
//

//Karakterlerin cümlelerinin gösterildiği yer.

import UIKit

class QuotesViewController: BaseViewController {

    @IBOutlet weak var quotesTableView: UITableView!{
        didSet {
            quotesTableView.dataSource = self
            quotesTableView.delegate = self
            quotesTableView.estimatedRowHeight = UITableView.automaticDimension
        }
    }
    
    var characterName: CharacterModel?
    
    private var quotes: [QuoteModel]? {
        didSet {
            quotesTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
        Client.getQuotes(author: characterName?.name ?? "") { [weak self] characterQuotes, error in
            guard let self = self,
            let quotes = characterQuotes else { return }
            self.indicator.stopAnimating()
            if quotes.isEmpty { //Karakterin cümlesi yoksa önceki ekrana gönderiyor.
                self.showErrorAlert(message: "No Quotes") {
                    self.navigationController?.popViewController(animated: true)
                }
                return
            }
            self.quotes = quotes
        }
        
    }
}

extension QuotesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let quote = quotes?[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = quote?.quote
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

