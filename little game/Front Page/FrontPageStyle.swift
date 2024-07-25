//
//  FrontPageStyle.swift
//  little game
//
//  Created by Stephen on 2024/7/25.
//

import UIKit

final class FrontPageStyle {
    func textViewStyle(_ textView: UITextView) {
        textView.layer.borderWidth = 1.2
        textView.layer.borderColor = UIColor(named: "MorningYellow")?.cgColor
        textView.layer.cornerRadius = 7
    }

    func buttonStyle(_ layer: CALayer) {
        layer.cornerRadius = 5
        layer.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
        layer.borderWidth = 2
    }
}
