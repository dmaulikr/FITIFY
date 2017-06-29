//
//  HistoryCell.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-23.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    
    @IBOutlet weak var cellTextLbl: UILabel!
    @IBOutlet weak var excercisesCompleteLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(text: String, isSelected: Bool) {
        cellTextLbl.text = text
        if isSelected {
            excercisesCompleteLbl.text = "YOLO"
        }
    }
    
    

}
