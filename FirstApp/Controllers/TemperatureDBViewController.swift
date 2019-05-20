//
//  TemperatureDataBaseViewController.swift
//  FirstApp
//
//  Created by Valentina Vențel on 12/05/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit

class TemperatureDBViewController: UIViewController, TemperatureModelProtocol {
    
    var feedItems: NSArray = NSArray()
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        let lastTemperature: Temperature = feedItems.lastObject as! Temperature
        temp.text = "\(lastTemperature.temperature ?? "0") ℃"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Temperature"
        name.text = NSLocalizedString("temp", comment: "")
        
        let temperatureModel = TemperatureModel()
        temperatureModel.delegate = self
        temperatureModel.downloadedItems()
        
        //let item: Temperature = feedItems[indexPath.row] as! Temperature
        
        //temp.text = item.temperature
        
    }
}
