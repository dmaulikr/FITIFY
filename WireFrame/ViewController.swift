//
//  ViewController.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-21.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit
import UserNotifications

extension Date {
    
    init?(dateString: String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        if let d = dateStringFormatter.date(from: dateString) {
            self.init(timeInterval: 0, since: d)
        } else {
            return nil
        }
    }
}
class ViewController: UIViewController,UNUserNotificationCenterDelegate, UITableViewDelegate, UITableViewDataSource {
    

    let time:TimeInterval = 10.0
    let snooze:TimeInterval = 5.0
    var isGrantedAccess = false
    
    @IBOutlet weak var tableView: UITableView!
    var uglyThings = ["s1", "s2", "s3"]
    var alternates = ["s4", "s5"]
    var uglyTitles = ["lunge", "squat", "cool"]
    
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
    
    func scheduleLocal() {
        let center = UNUserNotificationCenter.current()
        
        
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "Did you finish the excercise?"
        content.categoryIdentifier = "myCategory"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        
        var dateComponents = DateComponents()
        dateComponents.hour = 16
        dateComponents.minute = 53
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request)
    }
    
    func setCategories(){
        let snoozeAction = UNNotificationAction(identifier: "snooze", title: "Snooze 5 Sec", options: [])
        let commentAction = UNTextInputNotificationAction(identifier: "comment", title: "Add Comment", options: [], textInputButtonTitle: "Add", textInputPlaceholder: "Add Comment Here")
        let alarmCategory = UNNotificationCategory(identifier: "alarm.category",actions: [snoozeAction,commentAction],intentIdentifiers: [], options: [])
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
        if identifier == "snooze"{
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            newContent.body = "Snooze 5 Seconds"
            newContent.subtitle = "Snooze 5 Seconds"
            let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: snooze, repeats: false)
            addNotification(content: newContent, trigger: newTrigger, indentifier: request.identifier)
            
        }
        
        if identifier == "comment"{
            let textResponse = response as! UNTextInputNotificationResponse
            //commentsLabel.text = textResponse.userText
            let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
            newContent.body = textResponse.userText
            addNotification(content: newContent, trigger: request.trigger, indentifier: request.identifier)
        }
        
        completionHandler()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        //registerLocal()
        //scheduleLocal()
        
        
        //let delegate = UIApplication.shared.delegate as? AppDelegate
        //delegate?.scheduleNotification()
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        print("Hello")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "uglycell") as? UglyCell {
            let item = uglyThings[indexPath.row]
            let img = UIImage(named: item)
            cell.configureCell(image: img!, text: uglyTitles[indexPath.row])
            return cell
        }
        return UglyCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uglyThings.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    @IBAction func startButton(_ sender: Any) {
        if isGrantedAccess{
            let content = UNMutableNotificationContent()
            content.title = "Alarm"
            content.subtitle = "First Alarm"
            content.body = "First Alarm"
            content.sound = UNNotificationSound.default()
            content.categoryIdentifier = "alarm.category"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
            addNotification(content: content, trigger: trigger , indentifier: "Alarm")
        }
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let more = UITableViewRowAction(style: .normal, title: "Change Excercise") { action, index in
            print("more button tapped")
            self.uglyThings.remove(at: indexPath.row)
            self.uglyThings.append((self.alternates[self.alternates.count-1]))
            self.alternates.remove(at: self.alternates.count-1)
            self.tableView.reloadData()
        }
        more.backgroundColor = UIColor.lightGray
        
        return [more]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let e = Excercise(name: uglyTitles[indexPath.row])
        performSegue(withIdentifier: "info", sender: e)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info" {
            if let detailsVC = segue.destination as? ExcerciseInfoVC {
                if let str = sender as? Excercise {
                    detailsVC.str = str
                }
            }
        }
    }
    
    
    
}

