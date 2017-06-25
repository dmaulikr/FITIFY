//
//  AllGoalsVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-25.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class AllGoalsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    var goals = ["Lose 20 Lbs", "6 Pack Abs", "Stronger Legs", "Bigger Arms"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AllGoalsCell") as? AllGoalsCell {
            cell.configureCell(text: goals[indexPath.row])
            return cell
        }
        return UglyCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let e = goals[indexPath.row]
        performSegue(withIdentifier: "toExcercisePlaylist", sender: e)
    }
    

}
