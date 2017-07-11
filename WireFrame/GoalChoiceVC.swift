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
    @IBOutlet weak var descriptionView: UIView!

    
    var str: String = "Weight Loss"
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func changeLossDesc(_ sender: Any) {
        reset()
        descriptionLbl.text = "Here we give you exercises to help you lose that last 10 pounds"
        
        lossBtn.backgroundColor = UIColor.blue
        str = "Weight Loss"
        
    }
    
    @IBAction func changeLiftingDesc(_ sender: Any) {
        reset()
        descriptionLbl.text = "With this plan we gove you exercises to pack on mass in upper body muscles like shoulders and chest"
        
        upperButton.backgroundColor = UIColor.blue
        str = "Mass Gain"
    }
    
    @IBAction func changeStaminaDesc(_ sender: Any) {
        reset()
        descriptionLbl.text = "Here we give you exercises to support your endurance program"
        
        StaminaButton.backgroundColor = UIColor.blue
        str = "Stamina"
    }
    
    func reset() {
        descriptionLbl.isHidden = false
        descriptionView.isHidden = false
        lossBtn.backgroundColor = UIColor(red: 117/255, green: 167/255, blue: 1, alpha: 1)
        upperButton.backgroundColor = UIColor(red: 117/255, green: 167/255, blue: 1, alpha: 1)

        StaminaButton.backgroundColor = UIColor(red: 117/255, green: 167/255, blue: 1, alpha: 1)

    }
    
    @IBAction func goToMainPage(_ sender: Any) {
        performSegue(withIdentifier: "goalSelected", sender: str)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lossBtn.layer.cornerRadius = 5
        upperButton.layer.cornerRadius = 5
        
        StaminaButton.layer.cornerRadius = 5
        
        nextBtn.layer.cornerRadius = 5
        descriptionLbl.isHidden = true
        descriptionView.layer.cornerRadius = 5
        descriptionView.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goalSelected" {
            if let detailsVC = segue.destination as? TipsVC {
                if let str = sender as? String {
                    detailsVC.temp = str
                }
            }
        }
    }
}
