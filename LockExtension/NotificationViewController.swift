//
//  NotificationViewController.swift
//  LockExtension
//
//  Created by Dan Friyia on 2017-06-22.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = "You are fat"
    }

}
