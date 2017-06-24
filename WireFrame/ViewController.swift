//
//  ViewController.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-21.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var startWorkout: UIButton!
    @IBOutlet weak var weightLossLbL: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
    
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
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let identifier = response.actionIdentifier
        let request = response.notification.request
        
        if identifier == "done" {
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            CURRENT_EXCERCISE += 1
            if CURRENT_EXCERCISE >= excercisePlaylist.count {
                newContent.body = "Workout Complete 🙂"
                addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
                return
            }
            newContent.body = "Your current excercise is: \(excercisePlaylist[CURRENT_EXCERCISE].name)"
            addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
            
        }
        
        if identifier == "skip" {
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            excercisePlaylist.remove(at: 0)
            newContent.body = "Your Current Excercise is: \(excercisePlaylist[0].name)"
            self.tableView.reloadData()
            addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startWorkout.layer.cornerRadius = 5
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                self.isGrantedAccess = granted
                if granted{
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
        //self.tableView.reloadData()
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
            //content.subtitle = "First Alarm"
            content.body = "First Alarm"
            content.categoryIdentifier = "alarm.category"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
            addNotification(content: content, trigger: trigger , indentifier: "Alarm")
        }
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
}

