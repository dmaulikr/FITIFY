//
//  UglyCell.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-21.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class UglyCell: UITableViewCell {
    
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var mainLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainImg.isHidden = true
        mainImg.layer.cornerRadius = 5.0
        mainImg.clipsToBounds = true
    }
    
    func configureCell(image:UIImage, text: String) {
        mainImg.image = image
        mainLbl.text = text
    }
    
}
