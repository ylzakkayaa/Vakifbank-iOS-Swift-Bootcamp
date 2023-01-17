//
//  ViewController.swift
//  Odev3
//
//  Created by Yeliz Akkaya on 19.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var responseLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        Client.getRandom { randomQuotes, error in
            guard let firstRandom = randomQuotes?.en else { return }
            self.responseLabel.text = "\(firstRandom)"
        }
    }

    @IBAction func randomQuotesButton(_ sender: Any) {
        Client.getRandom { randomQuotes, error in
            guard let firstRandom = randomQuotes?.en else { return }
            self.responseLabel.text = "\(firstRandom)"
    }
    
}

}
