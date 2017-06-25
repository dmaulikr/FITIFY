//
//  HistoryInfoVC.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-23.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class HistoryInfoVC: UIViewController {
    
    @IBOutlet weak var titleLbL: UILabel!
    public var titleText:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbL.text = titleText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
