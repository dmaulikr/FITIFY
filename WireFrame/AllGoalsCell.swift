//
//  AllGoalsCell.swift
//  WireFrame
//
//  Created by Dan Friyia on 2017-06-25.
//  Copyright © 2017 Dan Friyia. All rights reserved.
//

import UIKit

class AllGoalsCell: UITableViewCell {

    
    @IBOutlet weak var cellTextLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(text: String) {
        cellTextLbl.text = text
    }

}
