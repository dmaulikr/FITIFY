//
//  ExcerciseHistoryVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-23.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class ExcerciseHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var excercises: [String] = ["Bench Press", "Lunge", "Crunch"]
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            excercises = ["Bench Press", "Lunge", "Crunch"]
            self.tableView.reloadData()
            break
        case 1:
            excercises = ["Leg Day", "Arm Day", "Abs Day"]
            self.tableView.reloadData()
            break
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell {
            cell.configureCell(text: excercises[indexPath.row])
            cell.backgroundColor = UIColor.white
            if excercises[indexPath.row] == "Bench Press" {
                cell.backgroundColor = UIColor.red
            }
            return cell
        }
        return UglyCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return excercises.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let e = excercises[indexPath.row]
        performSegue(withIdentifier: "HistoryInfo", sender: e)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HistoryInfo" {
            if let detailsVC = segue.destination as? HistoryInfoVC {
                if let str = sender as? String {
                    detailsVC.titleText = str
                }
            }
        }
    }
}
