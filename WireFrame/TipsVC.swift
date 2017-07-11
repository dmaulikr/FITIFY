//
//  TipsVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-07-11.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class TipsVC: UIViewController {
    
    var temp: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onNextClicked(_ sender: Any) {
        performSegue(withIdentifier: "tipComplete", sender: temp)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tipComplete" {
            if let detailsVC = segue.destination as? ViewController {
                if let str = sender as? String {
                    detailsVC.temp = str
                }
            }
        }
    }
}
