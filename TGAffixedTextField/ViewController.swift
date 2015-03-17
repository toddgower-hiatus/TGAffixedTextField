//
//  ViewController.swift
//  TGAffixedTextField
//
//  Created by Todd Gower on 3/7/15.
//  Copyright (c) 2015 Todd Gower. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var prefixTextField: TGAffixedTextField!
    @IBOutlet weak var suffixTextField: TGAffixedTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        prefixTextField.prefix = "($) "
        suffixTextField.suffix = " days"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

