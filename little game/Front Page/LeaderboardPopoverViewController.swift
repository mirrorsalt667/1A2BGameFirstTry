//
//  LeaderboardPopoverViewController.swift
//  little game
//
//  Created by Stephen on 2024/8/21.
//

import UIKit

final class LeaderboardPopoverViewController: UIViewController {
    @IBOutlet var timerLeaderboardButton: UIButton!
    @IBOutlet var countdownLeaderboardButton: UIButton!
    @IBOutlet var luckyLeaderboardButton: UIButton!
    
    private let frontPageStyle = FrontPageStyle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frontPageStyle.buttonStyle(timerLeaderboardButton.layer)
        frontPageStyle.buttonStyle(countdownLeaderboardButton.layer)
        frontPageStyle.buttonStyle(luckyLeaderboardButton.layer)
    }
    
    // MARK: Methods
    
    private func segueToLeaderboards(_ type: LeaderboardTypes) {
        let storyboard = UIStoryboard(name: "Leaderboard", bundle: nil)
        if let viewController = storyboard.instantiateViewController(identifier: "LeaderboardViewController") as? LeaderboardViewController {
            viewController.type = type
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
    }
}

// MARK: - Action

extension LeaderboardPopoverViewController {
    @IBAction private func toTimerPageAction(_ sender: UIButton) {
        segueToLeaderboards(.timer)
    }
    
    @IBAction private func toCountdownPageAction(_ sender: UIButton) {
        segueToLeaderboards(.countdown)
    }
    
    @IBAction private func toLuckyPageAction(_ sender: UIButton) {
        segueToLeaderboards(.lucky)
    }
}
