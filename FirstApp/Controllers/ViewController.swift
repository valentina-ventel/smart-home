//
//  ViewController.swift
//  FirstApp
//
//  Created by Valentina Vențel on 05/04/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit
import Foundation


class ViewController: UIViewController, HomeModelProtocol {
    
    @IBOutlet weak var pukText: UITextField!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var feedItems: NSArray = NSArray()
    var selectedUser: User = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func returnUser(feedItems: NSArray) -> User {
        var index = 0
        let user = User()
        
        while index < feedItems.count {
            let user: User = feedItems[index] as! User
            if (user.nume == userText.text) && (user.puk == pukText.text) {
                return user
            }
            index += 1
        }
        return user
    }
    
    @IBAction func loginTap(_ sender: UIButton) {
        let user: User = returnUser(feedItems: feedItems)
        if (user.nume == userText.text) && (user.puk == pukText.text) {
            performSegue(withIdentifier: "mainSegue", sender: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "User not found. \n Try again!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in }
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        
    }
}

