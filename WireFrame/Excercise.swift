//
//  Excercise.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-21.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import Foundation
import UIKit

public class Excercise {
    var name: String
    var description: String
    var img: UIImage!
    
    init(name: String, desc: String, image: UIImage) {
        self.name = name
        self.description = desc
        self.img = image
    }
}
