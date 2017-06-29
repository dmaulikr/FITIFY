//
//  ExcerciseHistoryVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-23.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class ExcerciseHistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    var workouts: [Workout] = [
        Workout(name: "Bench Press", completed: -1),
        Workout(name: "Lunge", completed: -1),
        Workout(name: "Leg Curl", completed: -1)
    ]
    
    var excerciseArray: [Workout] = [
        Workout(name: "Bench Press", completed: -1),
        Workout(name: "Lunge", completed: -1),
        Workout(name: "Leg Curl", completed: -1)
    ]
    
    var workoutArray: [Workout] = [
        Workout(name: "Leg Day", completed: 4),
        Workout(name: "Chest Day", completed: 3),
        Workout(name: "Full Body", completed: 2),
        Workout(name: "Arms Day", completed: 4),
        Workout(name: "Back Day", completed: 5),
        Workout(name: "Leg Day", completed: 2)
    ]
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            workouts = excerciseArray
            self.tableView.reloadData()
            break
        case 1:
            workouts = workoutArray
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
            cell.configureCell(text: workouts[indexPath.row].nameOfWorkout, isSelected: false)
            cell.backgroundColor = UIColor.white
            cell.excercisesCompleteLbl.text = ""
            
            switch workouts[indexPath.row].numOfExcercisesCompleted {
            case -1:
                break
            case 1:
                cell.backgroundColor = UIColor.red
                cell.excercisesCompleteLbl.text = workouts[indexPath.row].fractionOfExcercisesCompleted
                break
            case 2:
                cell.backgroundColor = UIColor.red
                cell.excercisesCompleteLbl.text = workouts[indexPath.row].fractionOfExcercisesCompleted
                break
            case 3:
                cell.backgroundColor = UIColor.yellow
                cell.excercisesCompleteLbl.text = workouts[indexPath.row].fractionOfExcercisesCompleted
                break
            case 4:
                cell.backgroundColor = UIColor.yellow
                cell.excercisesCompleteLbl.text = workouts[indexPath.row].fractionOfExcercisesCompleted
                break
            case 5:
                cell.backgroundColor = UIColor.green
                cell.excercisesCompleteLbl.text = workouts[indexPath.row].fractionOfExcercisesCompleted
                break
            default:
                break
            }
            
            return cell
        }
        return UglyCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let e = workouts[indexPath.row].nameOfWorkout
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
