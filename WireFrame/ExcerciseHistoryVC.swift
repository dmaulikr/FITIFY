//
//  ExcerciseHistoryVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-23.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class ExcerciseHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var excercises = ["Bench Press", "Lunge", "Crunch"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as? HistoryCell {
            cell.configureCell(text: excercises[indexPath.row])
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
