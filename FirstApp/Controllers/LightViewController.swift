//
//  LightViewController.swift
//  FirstApp
//
//  Created by Valentina Vențel on 06/04/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit

enum Room: Int {
    case hall = 0, living, kitchen
    
    func toString() -> String {
        switch self {
        case .hall:
            return "hall"
        case .living:
            return "living"
        case .kitchen:
            return "kitchen"
        }
    }
    
    func url() -> String {
        switch self {
        case .hall:
            return "updateLight.php"
        case .living:
            return "updateLivingLight.php"
        case .kitchen:
            return "updateKitchenLight.php"
        }
    }
}

class LightViewController: UIViewController, LightModelProtocol {
    
    var firstLight: Light = Light()
    var feedItems: NSArray = NSArray()
    let options = ["Hol", "Camera de zi", "Bucătarie"]
    @IBOutlet weak var lightTableView: UITableView!
    
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        firstLight = feedItems.firstObject as! Light
        lightTableView.reloadData()
        print (" Heiiii \(firstLight.kitchen!)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lightTableView.dataSource = self
        lightTableView.delegate = self
        // Do any additional setup after loading the view.
        title = "Lights"
        lightTableView.tableFooterView = UIView(frame: .zero)
        
        let lightModel = LightModel()
        lightModel.delegate = self
        lightModel.downloadedItems()
        
    }
    
    @objc func switchControl(_ sender: UISwitch) {
        
        var url: NSURL?
        var dataString = "secretWord=44fdcv8jf3"
        let room = Room(rawValue: sender.tag)?.toString()
        dataString += "&\(room!)=\(sender.isOn ? 1:0)"
        url = NSURL(string: "http://localhost/\(Room(rawValue: sender.tag)!.url())")
        
        /*
        switch sender.tag {
        case Room.hall.rawValue: do {
            if sender.isOn == true {
                print("S-a aprins")
                dataString = dataString + "&hall=\(1)"
            } else {
                print("S-a stins")
                dataString = dataString + "&hall=\(0)"
            }
            url = NSURL(string: "http://localhost/updateLight.php")
            }
            
        case Room.living.rawValue: do {
            if sender.isOn == true {
                print("S-a aprins 2")
                dataString = dataString + "&living=\(1)"
            } else {
                print("S-a stins 2")
                dataString = dataString + "&living=\(0)"
            }
            url = NSURL(string: "http://localhost/updateLivingLight.php")
            }
            
        case Room.kitchen.rawValue: do {
            if sender.isOn == true {
                print("S-a aprins 3")
                dataString = dataString + "&kitchen=\(1)"
            } else {
                print("S-a stins 3")
                dataString = dataString + "&kitchen=\(0)"
            }
            url = NSURL(string: "http://localhost/updateKitchenLight.php")
            }
            
        default:
            return
        } */
        
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        // convert the post string to utf8 format
        
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
        
        do
        {
            
            // the upload task, uploadJob, is defined here
            
            let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD)
            {
                data, response, error in
                
                if error != nil {
                    
                    // display an alert if there is an error inside the DispatchQueue.main.async
                    
                    DispatchQueue.main.async
                        {
                            let alert = UIAlertController(title: "Update Didn't Work?", message: "Looks like the connection to the server didn't work.  Do you have Internet access?", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                    }
                }
                else
                {
                    if let unwrappedData = data {
                        
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue) // Response from web server hosting the database
                        
                        if returnedData == "1" // insert into database worked
                        {
                            print("Olla")
                            
                            // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async
                            
                            DispatchQueue.main.async
                                {
                                    let alert = UIAlertController(title: "Update OK?", message: "Looks like the update into the database worked.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async
                            
                            DispatchQueue.main.async
                                {
                                    
                                    let alert = UIAlertController(title: "Update Didn't Work", message: "Looks like the update into the database did not worked.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                    }
                }
            }
            uploadJob.resume()
        }
    }
}

extension LightViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = lightTableView.dequeueReusableCell(withIdentifier: "lightCell", for: indexPath) as! LightCell
        cell.textLabel?.text = "\(options[indexPath.row])"
        cell.lightSwitch.tag = indexPath.row
        
        cell.lightSwitch.addTarget(self,
                                   action: #selector(switchControl(_:)),
                                   for: .valueChanged)
        
        switch cell.lightSwitch.tag {
        case Room.hall.rawValue:
            do {
                cell.lightSwitch.isOn = (firstLight.hall ?? 0) == 0 ? false : true
                    // ((firstLight.hall!) == 0 ? true:false)
            }
        case Room.living.rawValue:
            do {
                cell.lightSwitch.isOn = (firstLight.living ?? 0) == 0 ? false : true
                // ((firstLight.living!) == 0 ? true:false)
            }
        case Room.kitchen.rawValue:
            do {
                cell.lightSwitch.isOn = (firstLight.kitchen ?? 0) == 0 ? false : true
                    // ((firstLight.kitchen!) == 0 ? true:false)
            }
        default:
            print("Oops! Mai incearca o data!")
        }
        return cell
    }
}

extension LightViewController: UITableViewDelegate {
    
}
