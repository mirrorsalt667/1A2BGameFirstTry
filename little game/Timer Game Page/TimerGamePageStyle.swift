//
//  TimerGamePageStyle.swift
//  little game
//
//  Created by Stephen on 2024/7/25.
//

import UIKit

final class TimerGamePageStyle {
    // MARK: Appearence setting

    func addBorder(_ layer: CALayer) {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }

    func numberButtonStyle(_ button: UIButton) {
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.layer.backgroundColor = UIColor(named: "MorningGray")?.cgColor
        button.layer.cornerRadius = 7
        button.layer.shadowRadius = 7
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowColor = UIColor(named: "MorningBrown")?.cgColor
        button.layer.shadowOpacity = 1
    }

    // TextView
    func textViewStyle(_ layer: CALayer) {
        layer.cornerRadius = 18
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 18
        layer.shadowColor = UIColor(named: "MorningBlue3")?.cgColor
        layer.shadowOpacity = 1
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
    }

    // showNumberLabel
    func fillLabelColor(_ label: UILabel, text: String) {
        DispatchQueue.main.async {
            label.textColor = UIColor(named: "MorningOrange")
            label.text = text
        }
    }

    func emptyLabelColor(_ label: UILabel) {
        DispatchQueue.main.async {
            label.textColor = UIColor(named: "MorningBlue3")
            label.text = "0"
        }
    }
}
