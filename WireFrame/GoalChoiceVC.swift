//
//  GoalChoiceVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-24.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class GoalChoiceVC: UIViewController {

    
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var lossBtn: UIButton!
    @IBOutlet weak var upperButton: UIButton!
    @IBOutlet weak var StaminaButton: UIButton!
    @IBOutlet weak var changeStaminaDesc: UIButton!
    
    @IBAction func changeLossDesc(_ sender: Any) {
        descriptionLbl.text = "Here we give you excercises to help you lose that last 10 pounds"
    }
    
    @IBAction func changeLiftingDesc(_ sender: Any) {
        descriptionLbl.text = "With this plan we gove you excercises to pack on mass in upper body muscles like shoulders and chest"
    }
    
    @IBAction func changeStaminaDesc(_ sender: Any) {
        descriptionLbl.text = "Here we give you excercises to support your endurance program"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
