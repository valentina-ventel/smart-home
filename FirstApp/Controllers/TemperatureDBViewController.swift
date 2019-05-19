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
    var selectedTemperature: Temperature = Temperature()
    
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
