//
//  ExcerciseInfoVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-21.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit
import UserNotifications

class ExcerciseInfoVC: UIViewController {
    
    public var str: Excercise!
    public var temporaryArray: [Excercise]!
    
    @IBOutlet weak var setsCount: UILabel!
    @IBOutlet weak var repsCount: UILabel!
    @IBOutlet weak var weightCount: UILabel!
    @IBOutlet weak var replaceBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var excerciseNameLbl: UILabel!
    @IBOutlet weak var excerciseImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var repsStepperValueChanged: UIStepper!
    @IBOutlet weak var weightStepper: UIStepper!
    
    let time:TimeInterval = 3.0
    let snooze:TimeInterval = 5.0
    var isGrantedAccess = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excerciseNameLbl.text = str.name
        doneBtn.layer.cornerRadius = 5
        skipBtn.layer.cornerRadius = 5
        replaceBtn.layer.cornerRadius = 5
        descriptionLbl.text = str.description
        excerciseImg.image = str.img
        self.weightStepper.stepValue = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func topStepper(_ sender: Any) {
    }
    
    @IBAction func setsStepperValueChanged(_ sender: UIStepper) {
        setsCount.text = Int(sender.value).description
    }
    
    @IBAction func repsStepperValueChanged(_ sender: UIStepper) {
        repsCount.text = Int(sender.value).description
    }
    
    @IBAction func weightStepperValueChanged(_ sender: UIStepper) {
        let temp = Int(sender.value)
        weightCount.text = String(temp)
    }
    
    @IBAction func onDoneClicked(_ sender: Any) {
        isCompleted()
        print("\n\n\n\n\n You are here \(CURRENT_EXCERCISE)\n\n\n\n\n")
    }
    
    @IBAction func onSkipClicked(_ sender: Any) {
        isCompleted()
        
    }
    
    @IBAction func onReplaceClicked(_ sender: Any) {
        isCompleted()
        
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
    
    func isCompleted() {
        CURRENT_EXCERCISE += 1
        if CURRENT_EXCERCISE >= TOTAL_EXCERCISES {
            let content = UNMutableNotificationContent()
            content.title = "FITIFY Workout"
            content.body = "Workout Complete 🙂"
            content.categoryIdentifier = "alarm.category"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
            addNotification(content: content, trigger: trigger , indentifier: "Alarm")
        }
    }
    
    
}
