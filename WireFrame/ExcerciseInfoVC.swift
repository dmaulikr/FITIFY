//
//  ExcerciseInfoVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-21.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class ExcerciseInfoVC: UIViewController {
    
    public var str: Excercise!
    
    @IBOutlet weak var setsCount: UILabel!
    @IBOutlet weak var repsCount: UILabel!
    @IBOutlet weak var weightCount: UILabel!
    
    
    @IBOutlet weak var replaceBtn: UIButton!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    @IBOutlet weak var excerciseNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excerciseNameLbl.text = str.name
        // Do any additional setup after loading the view.
        doneBtn.layer.cornerRadius = 5
        skipBtn.layer.cornerRadius = 5
        replaceBtn.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func topStepper(_ sender: Any) {
        //setsCount.text = Int(sender).description
    }
    
    @IBAction func setsStepperValueChanged(_ sender: UIStepper) {
        setsCount.text = Int(sender.value).description
    }
    
    
    @IBOutlet weak var repsStepperValueChanged: UIStepper!
    
    @IBAction func repsStepperValueChanged(_ sender: UIStepper) {
        repsCount.text = Int(sender.value).description
    }
    
    @IBAction func weightStepperValueChanged(_ sender: UIStepper) {
        weightCount.text = Int(sender.value).description
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
