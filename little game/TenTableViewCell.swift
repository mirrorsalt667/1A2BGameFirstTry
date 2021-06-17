//
//  TenTableViewCell.swift
//  little game
//
//  Created by Stephen on 2021/6/16.
//

import UIKit

class TenTableViewCell: UITableViewCell {

    @IBOutlet weak var guess1Label: UILabel!
    @IBOutlet weak var guess2Label: UILabel!
    @IBOutlet weak var guess3Label: UILabel!
    @IBOutlet weak var guess4Label: UILabel!
    
    @IBOutlet weak var AcountLabel: UILabel!
    @IBOutlet weak var ALabel: UILabel!
    @IBOutlet weak var BcountLabel: UILabel!
    @IBOutlet weak var BLabel: UILabel!
    
    @IBOutlet weak var guess1_1Label: UILabel!
    @IBOutlet weak var guess2_1Label: UILabel!
    @IBOutlet weak var guess3_1Label: UILabel!
    @IBOutlet weak var guess4_1Label: UILabel!
    
    @IBOutlet weak var A_1countLabel: UILabel!
    @IBOutlet weak var A_1Label: UILabel!
    @IBOutlet weak var B_1countLabel: UILabel!
    @IBOutlet weak var B_1Label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
