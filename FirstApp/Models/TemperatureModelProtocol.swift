//
//  TemperatureModelProtocol.swift
//  FirstApp
//
//  Created by Valentina Vențel on 12/05/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit
import Foundation

protocol TemperatureModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class TemperatureModel: NSObject, URLSessionDataDelegate {
    weak var delegate: TemperatureModelProtocol!
    let urlPath = "http://localhost/script0.php"
    
    func downloadedItems() {
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print ("Failed to downloaded data")
            } else {
                print ("Data downloaded successfully")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    fileprivate func parseJSON(_ data: Data) {
        var jsonResult = NSArray()
        
        do {
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        } catch let error as NSError {
            print (error)
        }
        
        var jsonElement = NSDictionary()
        let temperatureArray = NSMutableArray()
        
        for i in 0 ..< jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            let temp = Temperature()
            
            
            
            if let temperature = jsonElement["temperature"] as? String,
                let stringDate = jsonElement["date"] as? String,
                let puk = jsonElement["ora"] as? String {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
                let date = dateFormatter.date(from:stringDate)!
                
                temp.temperature = temperature
                temp.data = date
                temp.puk = puk
            }
            temperatureArray.add(temp)
        }
        DispatchQueue.main.async(execute: { () -> Void in self.delegate.itemsDownloaded(items: temperatureArray)})
    }
}
