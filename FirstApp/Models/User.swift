//
//  TabelaUser.swift
//  FirstApp
//
//  Created by Valentina Vențel on 10/05/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit
import Foundation

class User: NSObject {

    var nume: String?
    var prenume: String?
    var id: String?
    var puk: String?
    
    var fullName: String {
        return "\(prenume!) \(nume!)"
    }
    
    override init() {
    }
    
    init(nume: String, prenume: String, id: String, puk: String) {
        self.nume = nume
        self.prenume = prenume
        self.id = id
        self.puk = puk
    }
    
    
    
    override var description: String {
        return "\(id!), \(puk!)"
    }

}
