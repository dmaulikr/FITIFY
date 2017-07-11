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
    @IBOutlet var doSkippedExcercisesBtn: UIButton!
    
    
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
    
    func workoutCompleteMessage(request: UNNotificationRequest) {
        self.tableView.reloadData()
        workoutArray.append(Workout(name: "Leg Day", completed: EXCERCISES_COMPLETED))
        workoutCompleteMessage(request: request)
        self.tableView.reloadData()
        hideAll()
        
        let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
        newContent.body = "Workout Complete 🙂"
        addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
    }
    
    func doneAndSkipHandler(isDone: Bool, request: UNNotificationRequest) {
        
        if isDone {
            EXCERCISES_COMPLETED += 1
        } else {
            skipped.append(excercisePlaylist.first!)
        }
        
        CURRENT_EXCERCISE += 1
        
        if CURRENT_EXCERCISE >= TOTAL_EXCERCISES {
            if isInSkippedExcercisesMode {
                if excercisePlaylist.count == 0 {
                    workoutCompleteMessage(request: request)
                    return
                }
            } else {
                workoutCompleteMessage(request: request)
                return
            }
        }
        
        if wasDisplayed[0] {
            excercisePlaylist.removeFirst()
            wasDisplayed.removeFirst()
        }
        
        let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
        if excercisePlaylist.isEmpty && isInSkippedExcercisesMode {
            newContent.body = "Workout Complete 🙂"
            addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
            self.tableView.reloadData()
            hideAll()

            return
        }
        
        newContent.body = "Your current excercise is: \(excercisePlaylist[0].name)"
        wasDisplayed[0] = true
        
        self.tableView.reloadData()
        addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startWorkout.layer.cornerRadius           = 5
        newGoalLbl.layer.cornerRadius             = 5
        doSkippedExcercisesBtn.layer.cornerRadius = 5
        checkProgress.layer.cornerRadius          = 5
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
            if !excercisePlaylist.isEmpty {
                let excercise = excercisePlaylist[indexPath.row]
                cell.configureCell(image: excercise.img!, text: excercise.name)
                
            } else {
                return UglyCell()
            }
            
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
            wasDisplayed[0] = true
            content.body = "Your current excercise is: \(excercisePlaylist[0].name)"
            self.tableView.reloadData()
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
    
    @IBAction func onDoSkippedExcercisesClicked(_ sender: Any) {
        skippedExcercisesMode()
    }
    
    func hideAll() {
        startWorkout.isHidden           = true
        tableView.isHidden              = true
        doSkippedExcercisesBtn.isHidden = false
        checkProgress.isHidden          = false
        congradulatoryLbl.isHidden      = false
    }
    
    func skippedExcercisesMode() {
        startWorkout.isHidden           = false
        tableView.isHidden              = false
        doSkippedExcercisesBtn.isHidden = true
        checkProgress.isHidden          = true
        congradulatoryLbl.isHidden      = true
        
        isInSkippedExcercisesMode = true
        excercisePlaylist = skipped
        self.tableView.reloadData()
    }
}

