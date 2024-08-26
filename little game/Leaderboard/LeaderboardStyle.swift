//
//  LeaderboardStyle.swift
//  little game
//
//  Created by Stephen on 2024/7/26.
//

import UIKit

final class LeaderboardStyle {
    func cellNumberLabelStyle(_ label: CALayer) {
        label.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
        label.borderWidth = 1
        label.cornerRadius = 3
        label.shadowRadius = 3
        label.shadowColor = UIColor.gray.cgColor
        label.shadowOffset = CGSize(width: 0.5, height: 0.5)
        label.shadowOpacity = 0.8
    }
}
