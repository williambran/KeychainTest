//
//  ViewController.swift
//  KeyChainTest
//
//  Created by wito on 12/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    let keychainManager = KeychainManager(identifier: "identificador", accessGroup: nil)

    @IBAction func getValue(_ sender: UIButton) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        keychainManager["identificador"] = "agregar"
        keychainManager["identificador"] = "agregar"
        
        print(keychainManager["identificador"])
    }
    

}

