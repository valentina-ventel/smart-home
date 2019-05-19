//
//  ControlModesViewController.swift
//  FirstApp
//
//  Created by Valentina Vențel on 05/04/2019.
//  Copyright © 2019 Valentina Vențel. All rights reserved.
//

import UIKit

class ControlModesViewController: UIViewController {
    
    let options = ["Bluetooth", "Wi-Fi"]

    @IBOutlet weak var controlModesView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        controlModesView.dataSource = self
        controlModesView.delegate = self
        title = "Control modes"
        controlModesView.tableFooterView = UIView(frame: .zero)
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
extension ControlModesViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = controlModesView.dequeueReusableCell(withIdentifier: "controlModesCell", for: indexPath)
        cell.textLabel?.text = "\(options[indexPath.row])"
        return cell
    }
}

extension ControlModesViewController: UITableViewDelegate {
}
