//
//  Browser.swift
//  mayk
//
//  Created by Yura on 10/24/20.
//

import UIKit
import WebKit

class Browser: UIViewController, WKUIDelegate {
    
    var streamWebURL: URL?
    
    var webView: WKWebView!
        
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let streamURL = streamWebURL {
            let request = URLRequest(url: streamURL)
            
            webView.load(request)
        }
    }
    
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true) {
            
        }
    }
    

}
