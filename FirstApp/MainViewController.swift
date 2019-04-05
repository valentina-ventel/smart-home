//
//  MainViewController.swift
//  FirstApp
//
//  Created by Valentina Vențel on 05/04/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let optiuni = ["Control modes", "Light", "Temperature"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
         title = "iHome"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = ""
    }
    

    
    // MARK: - Navi

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
}

extension MainViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
            return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optiuni.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        cell.textLabel?.text = "\(indexPath.section):\(indexPath.row) \(optiuni[indexPath.row])"
        
        cell.imageView?.image = UIImage(named: "shutterstock_home_automation_pikaczy")
        
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "controlSegue", sender: nil)
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32.0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
        view.backgroundColor = UIColor.init(white: 0.3, alpha: 0.9)
        
        return view
    }


}


