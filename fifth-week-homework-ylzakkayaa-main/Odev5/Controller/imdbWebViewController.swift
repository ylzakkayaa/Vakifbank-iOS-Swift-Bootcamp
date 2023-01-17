//
//  imdbWebViewController.swift
//  Odev4
//
//  Created by Yeliz Akkaya on 27.11.2022.
//
//IMDB sayfasının göründüğü web view.

import UIKit
import WebKit

class imdbWebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           
           let urlString = "https://www.imdb.com/title/tt0903747/"
           if let url = URL(string: urlString) {
               webView.navigationDelegate = self
               webView.load(URLRequest(url: url))
           }
           
           let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
           toolbarItems = [refresh]
           navigationController?.isToolbarHidden = false
       }
       
       func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           title = "Breakin Bad"
       }
   }
