//
//  BaseViewController.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 27.11.2022.
//
//Ortak özellikleri kullanmak için oluşturdum. indicator ve alert kullanmak için ekledim.

import UIKit
import MaterialActivityIndicator
import SwiftAlertView

class BaseViewController: UIViewController {

    let indicator = MaterialActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicatorView()
    }
    
    private func setupActivityIndicatorView() {
        view.addSubview(indicator)
        setupActivityIndicatorViewConstraints()
    }
    
    private func setupActivityIndicatorViewConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showErrorAlert(message: String, completion: @escaping () -> Void) {
        SwiftAlertView.show(title: "Error",
                            message: message,
                            buttonTitles: ["OK"]).onButtonClicked { _, _ in
            completion()
        }
    }
}
