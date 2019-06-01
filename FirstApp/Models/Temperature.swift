//
//  Temperature.swift
//  FirstApp
//
//  Created by Valentina Vențel on 12/05/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit

class Temperature: NSObject {
   var temperature: Float?
   var data: Date?
//    var puk: String?
    var id: Int?
    
    
    override init() {}
    
    init(temperature: Float, data: Date, id: Int) {
        self.temperature = temperature
        self.data = data
        self.id = id
    }
    
    override var description: String {
        return "\(data!), \(id!)"
    }
}
