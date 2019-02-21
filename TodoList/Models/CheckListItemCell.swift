//
//  CheckListItemCellTableViewCell.swift
//  TodoList
//
//  Created by lpiem on 21/02/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class CheckListItemCell: UITableViewCell {
    
    @IBOutlet weak var todoChecked: UILabel!
    @IBOutlet weak var todoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
