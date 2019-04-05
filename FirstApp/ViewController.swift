//
//  ViewController.swift
//  FirstApp
//
//  Created by Valentina Vențel on 05/04/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pukText: UITextField!
    @IBOutlet weak var userText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if userIsLogged() {
            performSegue(withIdentifier: "mainSegue", sender: self)
        }
    }
}

func userIsLogged() -> Bool {
    //TODO: check if user is really logged in
    return true
}

