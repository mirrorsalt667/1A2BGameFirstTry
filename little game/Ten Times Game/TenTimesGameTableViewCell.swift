//
//  TenTimesGameTableViewCell.swift
//  little game
//
//  Created by Stephen on 2021/6/16.
//

import UIKit

final class TenTimesGameTableViewCell: UITableViewCell {
    @IBOutlet var guessing1Label: UILabel!
    @IBOutlet var guessing2Label: UILabel!
    @IBOutlet var guessing3Label: UILabel!
    @IBOutlet var guessing4Label: UILabel!

    @IBOutlet var aCounterLabel: UILabel!
    @IBOutlet var aLabel: UILabel!
    @IBOutlet var bCounterLabel: UILabel!
    @IBOutlet var bLabel: UILabel!

    @IBOutlet var guessing1_1Label: UILabel!
    @IBOutlet var guessing2_1Label: UILabel!
    @IBOutlet var guessing3_1Label: UILabel!
    @IBOutlet var guessing4_1Label: UILabel!

    @IBOutlet var a_1counterLabel: UILabel!
    @IBOutlet var a_1Label: UILabel!
    @IBOutlet var b_1counterLabel: UILabel!
    @IBOutlet var b_1Label: UILabel!
    
    // MARK: Methods
    
    /// A and B Stroke
    func addLabelStroke(_ layer: CALayer) {
        layer.cornerRadius = 2
        layer.borderWidth = 1
        layer.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
    }
    
    func removeLabelStroke(_ layer: CALayer) {
        layer.borderWidth = 0
    }
    
    func clearStrokeColor(_ layer: CALayer) {
        layer.borderWidth = 0
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
