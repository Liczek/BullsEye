//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Paweł Liczmański on 31.10.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    
    
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url){
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webView.load(htmlData, mimeType: "text/html", textEncodingName: "UTF-8", baseURL: baseURL)
            }
            
        }
        

    }

}
