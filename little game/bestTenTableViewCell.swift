//
//  bestTenTableViewCell.swift
//  little game
//
//  Created by 黃肇祺 on 2021/6/10.
//

import UIKit

class bestTenTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var guessTimesLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
