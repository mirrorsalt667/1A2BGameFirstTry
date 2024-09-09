//
//  FrontPageViewController.swift
//  little game
//
//  Created by Stephen on 2021/6/13.
//

import UIKit

final class FrontPageViewController: UIViewController {
    @IBOutlet var startGameButton: UIButton!
    @IBOutlet var leaderboardButton: UIButton!
    @IBOutlet var localLeaderboardButton: UIButton!
    @IBOutlet var playerInfoButton: UIButton!
    @IBOutlet var explanationTextView: UITextView!

    private let frontPageStyle = FrontPageStyle()
    private let store = StoreLeaderboardModel()
    private let apiManager = APIManager()

    private var localTimerLeaderboards = [LeaderboardData]()
    private var localCountdownLeaderboards = [LeaderboardData]()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        frontPageStyle.textViewStyle(explanationTextView)
        frontPageStyle.buttonStyle(startGameButton.layer)
        frontPageStyle.buttonStyle(leaderboardButton.layer)
        frontPageStyle.buttonStyle(localLeaderboardButton.layer)
        frontPageStyle.buttonStyle(playerInfoButton.layer)

        // Read old leaderboard, if data exist, then show the localLeaderboard Button
        let timerMode = store.loadingSavedData(mode: .timerMode)
        let countdownMode = store.loadingSavedData(mode: .tenTimesMode)
        localTimerLeaderboards = timerMode ?? []
        localCountdownLeaderboards = countdownMode ?? []
        if timerMode == nil && countdownMode == nil {
            DispatchQueue.main.async {
                self.localLeaderboardButton.isHidden = true
            }
        } else {
            DispatchQueue.main.async {
                self.localLeaderboardButton.isHidden = false
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstOpen() {
            print("Create a new player")
            createPlayerDataAndSave()
        }
    }

    @IBAction func unwindToFront(_: UIStoryboardSegue) {
        if isFirstOpen() {
            print("Create a new player")
            createPlayerDataAndSave()
        }
    }
}

// MARK: -  Methods

extension FrontPageViewController {
    func isFirstOpen() -> Bool {
        if store.loadPlayerData() != nil {
            return false
        }
        return true
    }

    func createPlayerDataAndSave() {
        apiManager.generateNewPlayer { result in
            switch result {
            case .success(let player):
                print("player id: \(player.player_id_str)")
                self.store.savePlayerData(player)
            case .failure(let error):
                print(">>> generate error: \(error)")
                let errorMessage = error.localizedDescription
                if errorMessage.contains("Could not connect to the server") {
                    self.alertWindow()
                }
            }
        }
    }

    /// Show alert window
    private func alertWindow() {
        let alert = UIAlertController(title: "連線錯誤", message: "伺服器連線失敗，暫時無法紀錄排行榜。", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - popover controller delegate

extension FrontPageViewController: UIPopoverPresentationControllerDelegate {
    // To display the submenu page on mobile, without this, it will appear as a full page.
    func adaptivePresentationStyle(for _: UIPresentationController, traitCollection _: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

// MARK: - Prepare

extension FrontPageViewController {
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
//        let screenWidth = self.view.window?.screen.bounds.width
        if segue.identifier == "PlayModePopover" {
            let popoverVC = segue.destination as! GamePopoverViewController
            popoverVC.preferredContentSize = CGSize(width: 300, height: 180)
            let popover = segue.destination.popoverPresentationController
            popover?.delegate = self
        } else if segue.identifier == "LeaderboardModePopover" {
            let popoverVC = segue.destination as! LeaderboardPopoverViewController
            popoverVC.preferredContentSize = CGSize(width: 300, height: 320)
            let popover = segue.destination.popoverPresentationController
            popover?.delegate = self
        } else if segue.identifier == "OldLeaderboardSegue" {
            if let viewController = segue.destination as? LeaderboardTableViewController {
                viewController.localTimerLeaderboards = localTimerLeaderboards
                viewController.localCountdownLeaderboards = localCountdownLeaderboards
            }
        }
    }
}
