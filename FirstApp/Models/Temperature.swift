//
//  Temperature.swift
//  FirstApp
//
//  Created by Valentina Vențel on 12/05/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit

class Temperature: NSObject {
    var temperature: String?
    var data: Date?
    var puk: String?
    
    override init() {}
    
    init(temperature: String, data: Date, puk: String) {
        self.temperature = temperature
        self.data = data
        self.puk = puk
    }
    
    override var description: String {
        return "\(data!), \(puk!)"
    }
}
