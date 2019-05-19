//
//  TemperatureViewController.swift
//  FirstApp
//
//  Created by Valentina Vențel on 17/05/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit



class TemperatureViewController: UIViewController, TemperatureModelProtocol {

    @IBOutlet weak var temperatureTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var displayTempCell: UITableViewCell!
    private var datePiker: UIDatePicker?
    
    
    @IBAction func uploadData(_ sender: Any) {
        let url = NSURL(string: "http://172.20.10.11/conectDB.php") // locahost MAMP - change to point to your database server

        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"

        var dataString = "secretWord=44fdcv8jf3" // starting POST string with a secretWord

        // the POST string has entries separated by &

        dataString = dataString + "&temperatureTextField=\(temperatureTextField.text!)" // add items as name and value
        dataString = dataString + "&dateTextField=\(dateTextField.description)"

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
                            let alert = UIAlertController(title: "Upload Didn't Work?",
                                                          message: "Looks like the connection to the server didn't work.  Do you have Internet access?",
                                                          preferredStyle: .alert)
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
                                    let alert = UIAlertController(title: "Upload OK?", message: "Looks like the upload and insert into the database worked.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                            }
                        }
                        else
                        {
                            // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async

                            DispatchQueue.main.async
                                {

                                    let alert = UIAlertController(title: "Upload Didn't Work", message: "Looks like the insert into the database did not worked.", preferredStyle: .alert)
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
    
    var feedItems: NSArray = NSArray()
    var selectedTemperature: Temperature = Temperature()
    
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        if feedItems.count == 0 {
            return
        }
        let lastTemperature: Temperature = feedItems.lastObject as! Temperature
        
        displayTempCell.textLabel!.text = "\(lastTemperature.temperature ?? "0") ℃"
        displayTempCell.detailTextLabel?.text = "\(lastTemperature.description)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePiker = UIDatePicker()
        datePiker?.datePickerMode = .date
        datePiker?.addTarget(self, action: #selector(TemperatureViewController.dateChange(datePiker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TemperatureViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        dateTextField.inputView = datePiker
        
        title = "Temperature"
        
        
        let temperatureModel = TemperatureModel()
        temperatureModel.delegate = self
        temperatureModel.downloadedItems()
       
        // Do any additional setup after loading the view.
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChange(datePiker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        dateTextField.text = dateFormatter.string(from: datePiker.date)
        view.endEditing(true)
    }
   
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
