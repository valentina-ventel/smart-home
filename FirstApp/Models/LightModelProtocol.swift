//
//  LightModelProtocol.swift
//  FirstApp
//
//  Created by Valentina Vențel on 19/05/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit
import Foundation

protocol LightModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class LightModel: NSObject, URLSessionDataDelegate {
    weak var delegate: LightModelProtocol!
    let urlPath = "http://localhost/lightControls.php"
    
    func downloadedItems() {
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url) {
            (data, response, error) in
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
        let lightArray = NSMutableArray()
        
        for i in 0 ..< jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            let light = Light()
            
            if let hall = jsonElement["hall"] as? Int,
                let living = jsonElement["living_room"] as? Int,
                let kitchen = jsonElement["kitchen"] as? Int {
                light.hall = hall
                light.living = living
                light.kitchen = kitchen
            }
            lightArray.add(light)
        }
        DispatchQueue.main.async(execute: { () -> Void in self.delegate.itemsDownloaded(items: lightArray)})
    }
}
