//
//  QuestionVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-29.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class QuestionVC: UIViewController {

    @IBOutlet weak var yesBtn: UIButton!
    
    @IBOutlet weak var noBtn: UIButton!
    
    @IBOutlet weak var maybeBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yesBtn.layer.cornerRadius = 5
        noBtn.layer.cornerRadius = 5
        maybeBtn.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
