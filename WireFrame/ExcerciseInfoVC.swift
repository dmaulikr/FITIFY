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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        excerciseNameLbl.text = str.name
        doneBtn.layer.cornerRadius = 5
        skipBtn.layer.cornerRadius = 5
        replaceBtn.layer.cornerRadius = 5
        descriptionLbl.text = str.description
        excerciseImg.image = str.img
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
        weightCount.text = Int(sender.value).description
    }
}
