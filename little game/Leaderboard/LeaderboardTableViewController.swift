//
//  LeaderboardTableViewController.swift
//  little game
//
//  Created by Stephen on 2021/6/10.
//

import UIKit

final class LeaderboardTableViewController: UITableViewController {
    private let style = LeaderboardStyle()
    var localTimerLeaderboards = [LeaderboardData]()
    var localCountdownLeaderboards = [LeaderboardData]()

    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Sort
        localTimerLeaderboards = sortTimerTableDataSource(localTimerLeaderboards)
        localCountdownLeaderboards = sortCountdownTableDataSource(localCountdownLeaderboards)
        tableView.reloadData()
    }

    /// Sort timer array
    private func sortTimerTableDataSource(_ input: [LeaderboardData]) -> [LeaderboardData] {
        // Less seconds, the better
        var sortedLeaderboards = input.sorted {
            if $0.second == $1.second {
                return Int($0.guess)! < Int($1.guess)!
            } else {
                return $0.second < $1.second
            }
        }
        if sortedLeaderboards.count != 0 {
            let title = sortedLeaderboards.last!
            sortedLeaderboards.removeLast()
            sortedLeaderboards.insert(title, at: 0)
        }
        return sortedLeaderboards
    }
    
    /// Sort countdown array
    private func sortCountdownTableDataSource(_ input: [LeaderboardData]) -> [LeaderboardData]  {
        // More times left, the better
        var sortedLeaderboards = input.sorted {
            if $0.guess == $1.guess {
                return $0.second < $1.second
            } else {
                return Int($0.guess)! > Int($1.guess)!
            }
        }
        if sortedLeaderboards.count != 0 {
            let title = sortedLeaderboards.last!
            sortedLeaderboards.removeLast()
            sortedLeaderboards.insert(title, at: 0)
        }
        return sortedLeaderboards
    }

    // MARK: - Table View

    override func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return localTimerLeaderboards.count
        } else if section == 1 {
            return localCountdownLeaderboards.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardTableViewCell", for: indexPath) as! LeaderboardTableViewCell
        let section = indexPath.section
        let row = indexPath.row
        cell.labelLayout()
        if section == 0 {
            handleTableViewDataSource(cell: cell, row: row, dataSource: localTimerLeaderboards)
        } else if section == 1 {
            handleTableViewDataSource(cell: cell, row: row, dataSource: localCountdownLeaderboards)
        }
        return cell
    }
    
    /// Show leaderboard via game type
    private func handleTableViewDataSource(cell: LeaderboardTableViewCell, row: Int, dataSource: [LeaderboardData]) {
        switch row {
        case 0:
            cell.numberLabel.text = ""
            cell.secondLabel.text = (dataSource[row].second)
            cell.guessTimesLabel.text = (dataSource[row].guess)
            cell.answerLabel.text = dataSource[row].answer
            cell.dateLabel.text = dataSource[row].date
        case 1, 2, 3:
            cell.numberLabel.text = "👑\(row)"
            cell.numberLabel.textColor = UIColor(named: "king")
            style.cellNumberLabelStyle(cell.numberLabel.layer)
            cell.secondLabel.text = "\(dataSource[row].second)秒"
            cell.guessTimesLabel.text = "\(dataSource[row].guess)次"
            cell.answerLabel.text = dataSource[row].answer
            cell.dateLabel.text = dataSource[row].date
        default:
            cell.numberLabel.text = String(row)
            style.cellNumberLabelStyle(cell.numberLabel.layer)
            cell.secondLabel.text = "\(dataSource[row].second)秒"
            cell.guessTimesLabel.text = "\(dataSource[row].guess)次"
            cell.answerLabel.text = dataSource[row].answer
            cell.dateLabel.text = dataSource[row].date
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if localTimerLeaderboards.isEmpty {
                return ""
            }
            return "計時模式"
        } else if section == 1 {
            if localCountdownLeaderboards.isEmpty {
                return ""
            }
            return "10次模式"
        }
        return ""
    }
}
