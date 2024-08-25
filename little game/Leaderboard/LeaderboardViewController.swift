//
//  LeaderboardViewController.swift
//  little game
//
//  Created by Stephen on 2024/8/22.
//

import UIKit

final class LeaderboardViewController: UIViewController {
    // Components
    
    @IBOutlet private var tableView: UITableView!
    
    // Variables
    
    private let style = LeaderboardStyle()
    private let apiRequest = APIManager()
    var timerLeaderboards = [Leaderboards]()
    var countdownLeaderboards = [Leaderboards]()
    var luckyLeaderboards = [Leaderboards]()
    var mainDataSource = [Leaderboards]()
    var type: LeaderboardTypes?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLeaderboards()
    }
    
    // MARK: - Methods
    
    private func getCurrentLeaderboards() {
        apiRequest.getLeaderboards { result in
            switch result {
            case .success(let data):
                let handleData = self.splitLeaderboardsViaMode(data)
                self.timerLeaderboards = handleData.0
                self.countdownLeaderboards = handleData.1
                self.luckyLeaderboards = handleData.2
                switch self.type {
                case .some(.timer): self.mainDataSource = self.timerLeaderboards
                case .some(.countdown): self.mainDataSource = self.countdownLeaderboards
                case .some(.lucky): self.mainDataSource = self.luckyLeaderboards
                case .none: break
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(">>> Get Leaderboard Error: \(error)")
            }
        }
    }
    
    private func splitLeaderboardsViaMode(_ total: [Leaderboards]) -> ([Leaderboards], [Leaderboards], [Leaderboards]) {
        var timer = [Leaderboards]()
        var countdown = [Leaderboards]()
        var lucky = [Leaderboards]()
        for item in total {
            switch item.mode {
            case 0: timer.append(item)
            case 1: countdown.append(item)
            case 2: lucky.append(item)
            default: break
            }
        }
        return (timer, countdown, lucky)
    }
}

// MARK: - Table View

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as! LeaderboardCell
        let row = indexPath.row
        cell.labelLayout()
        switch row {
        case 0:
            cell.numberLabel.text = ""
            cell.secondLabel.text = "時間"
            switch type {
            case .some(.timer):
                cell.guessTimesLabel.text = "猜"
            case .some(.countdown):
                cell.guessTimesLabel.text = "剩餘"
            case .some(.lucky):
                cell.guessTimesLabel.text = ""
            case .none:
                cell.guessTimesLabel.text = ""
            }
            cell.answerLabel.text = "答案"
            cell.dateLabel.text = "日期"
        case 1, 2, 3:
            style.firstThreeNumberStyle(cell.numberLabel)
            cell.numberLabel.text = "👑\(row + 1)"
            cell.numberLabel.textColor = UIColor(named: "king")
            style.cellNumberLabelStyle(cell.numberLabel.layer)
            cell.secondLabel.text = "\(mainDataSource[row + 1].seconds)秒"
            style.firstThreeNumberStyle(cell.secondLabel)
            cell.guessTimesLabel.text = "\(mainDataSource[row + 1].times)次"
            style.firstThreeNumberStyle(cell.guessTimesLabel)
            cell.answerLabel.text = mainDataSource[row + 1].answer
            style.firstThreeNumberStyle(cell.answerLabel)
            cell.dateLabel.text = mainDataSource[row + 1].timestamp
            style.firstThreeNumberStyle(cell.dateLabel)
        default:
            cell.numberLabel.text = String(row + 1)
            style.cellNumberLabelStyle(cell.numberLabel.layer)
            cell.secondLabel.text = "\(mainDataSource[row + 1].seconds)秒"
            cell.guessTimesLabel.text = "\(mainDataSource[row + 1].times)次"
            cell.answerLabel.text = mainDataSource[row + 1].answer
            cell.dateLabel.text = mainDataSource[row + 1].timestamp
        }
        return cell
    }
}
