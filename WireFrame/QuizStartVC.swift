//
//  QuizStartVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-23.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class QuizStartVC: UIViewController {

    
    @IBOutlet weak var quizLbl: UIButton!
    @IBOutlet weak var skipLbl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizLbl.layer.cornerRadius = 5
        skipLbl.layer.cornerRadius = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
