//
//  ViewController.swift
//  BullsEye
//
//  Created by Paweł Liczmański on 29.10.2016.
//  Copyright © 2016 Paweł Liczmański. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var targetValue: String = String(0)
    
    
    @IBOutlet weak var targetValueLabel: UILabel!
  

    override func viewDidLoad() {
        super.viewDidLoad()
       
        targetValueLabel.text = String(1 + arc4random_uniform(100))
        
    }

    

}

