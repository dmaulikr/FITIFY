//
//  ViewController.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-21.
//  Copyright © 2017 Dan Friyia. All rights reserved.


import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var startWorkout: UIButton!
    @IBOutlet weak var weightLossLbL: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var checkProgress: UIButton!
    @IBOutlet weak var congradulatoryLbl: UILabel!
    @IBOutlet weak var newGoalLbl: UIButton!
    var temp: String?
    
    
    var wasDisplayed = [false, false, false, false, false]
    
    let time:TimeInterval = 3.0
    let snooze:TimeInterval = 5.0
    var isGrantedAccess = false
    
    @IBOutlet weak var tableView: UITableView!
    var transferExcercise: Excercise!
    
    func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    func setCategories(){
        let snoozeAction = UNNotificationAction(identifier: "done", title: "Done", options: [])
        let helloAction = UNNotificationAction(identifier: "replace", title: "Replace", options: [])

        let commentAction = UNNotificationAction(identifier: "skip", title: "Skip", options: [])
        let alarmCategory = UNNotificationCategory(identifier: "alarm.category",actions: [snoozeAction,commentAction, helloAction],intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([alarmCategory])
    }
    
    func addNotification(content:UNNotificationContent,trigger:UNNotificationTrigger?, indentifier:String){
        let request = UNNotificationRequest(identifier: indentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: {
            (errorObject) in
            if let error = errorObject{
                print("Error \(error.localizedDescription) in notification \(indentifier)")
            }
        })
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    /*
        Handles the notifications:
            done:    Handles the done button
            skip:    Handles the skip button
            replace: Handles the replace button
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let identifier = response.actionIdentifier
        let request = response.notification.request
        
        self.tableView.reloadData()
        
        if identifier == "done" {
            doneAndSkipHandler(isDone: true, request: request)
        }
        
        if identifier == "skip" {
            doneAndSkipHandler(isDone: false, request: request)
        }
        
        if identifier == "replace" {
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            excercisePlaylist.remove(at: 0)
            excercisePlaylist.append(alternateExcercises.remove(at: alternateExcercises.endIndex-1))
            newContent.body = "Your Current Excercise is: \(excercisePlaylist[0].name)"
            self.tableView.reloadData()
            addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
        }
        
        completionHandler()
    }
    
    func doneAndSkipHandler(isDone: Bool, request: UNNotificationRequest) {
        
        if isDone {
            EXCERCISES_COMPLETED += 1
        }
        
        let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
        
        CURRENT_EXCERCISE    += 1
        
        if CURRENT_EXCERCISE >= TOTAL_EXCERCISES {
            excercisePlaylist.removeAll()
            self.tableView.reloadData()
            newContent.body = "Workout Complete 🙂"
            workoutArray.append(Workout(name: "Leg Day", completed: EXCERCISES_COMPLETED))
            addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
            self.tableView.reloadData()
            hideAll()
            return
        }
        
        if wasDisplayed[0] {
            excercisePlaylist.removeFirst()
            wasDisplayed.removeFirst()
        }
        
        newContent.body = "Your current excercise is: \(excercisePlaylist[0].name)"
        wasDisplayed[0] = true
        
        self.tableView.reloadData()
        addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startWorkout.layer.cornerRadius = 5
        newGoalLbl.layer.cornerRadius = 5
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                self.isGrantedAccess = granted
                if granted {
                    self.setCategories()
                } else {
                    let alert = UIAlertController(title: "Notification Access", message: "In order to use this application, turn on notification permissions.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert , animated: true, completion: nil)
                }
        })
        tableView.delegate = self
        tableView.dataSource = self
        if excercisePlaylist.isEmpty {
            hideAll()
        }
        if temp != nil {
            weightLossLbL.text = temp
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "uglycell") as? UglyCell {
            let excercise = excercisePlaylist[indexPath.row]
            cell.configureCell(image: excercise.img!, text: excercise.name)
            return cell
        }
        return UglyCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return excercisePlaylist.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func startButton(_ sender: Any) {
        
        if isGrantedAccess{
            let content = UNMutableNotificationContent()
            content.title = "FITIFY Workout"
            //isStartButtonClicked = true
            wasDisplayed[0] = true
            content.body = "Your current excercise is: \(excercisePlaylist[0].name)"
            self.tableView.reloadData()
            //EXCERCISES_COMPLETED += 1
            content.categoryIdentifier = "alarm.category"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
            addNotification(content: content, trigger: trigger , indentifier: "Alarm")
        }
        
        startWorkout.setTitle("Continue", for: .normal)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let more = UITableViewRowAction(style: .normal, title: "Change Excercise") { action, index in
            excercisePlaylist.remove(at: indexPath.row)
            excercisePlaylist.append(alternateExcercises.remove(at: alternateExcercises.endIndex-1))
            self.tableView.reloadData()
        }
        more.backgroundColor = UIColor.red
        
        return [more]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let e = excercisePlaylist[indexPath.row]
        performSegue(withIdentifier: "info", sender: e)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info" {
            if let detailsVC = segue.destination as? ExcerciseInfoVC {
                if let str = sender as? Excercise {
                    detailsVC.str = str
                    detailsVC.temporaryArray = excercisePlaylist
                }
            }
        }
        if segue.identifier == "history" {
            
        }
    }
    
    
    func hideAll() {
        startWorkout.isHidden      = true
        tableView.isHidden         = true
        checkProgress.isHidden     = false
        congradulatoryLbl.isHidden = false
    }
}

