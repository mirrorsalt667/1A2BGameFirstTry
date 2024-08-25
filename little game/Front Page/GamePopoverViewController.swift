//
//  GamePopoverViewController.swift
//  little game
//
//  Created by Stephen on 2024/8/21.
//

import UIKit

final class GamePopoverViewController: UIViewController {
    @IBOutlet var timerModeButton: UIButton!
    @IBOutlet var countdownModeButton: UIButton!

    private let frontPageStyle = FrontPageStyle()

    override func viewDidLoad() {
        super.viewDidLoad()
        frontPageStyle.buttonStyle(timerModeButton.layer)
        frontPageStyle.buttonStyle(countdownModeButton.layer)
    }
}
