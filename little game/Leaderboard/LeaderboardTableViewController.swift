//
//  LeaderboardTableViewController.swift
//  little game
//
//  Created by Stephen on 2021/6/10.
//

import UIKit

final class LeaderboardTableViewController: UITableViewController {

    private let style = LeaderboardStyle()
    var leaderboardData: [LeaderboardData] = []
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Table View

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return leaderboardData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as! LeaderboardTableViewCell
        let row = indexPath.row
        cell.labelLayout()
        switch row {
        case 0:
            cell.numberLabel.text = ""
            cell.secondLabel.text = (leaderboardData[row].second)
            cell.guessTimesLabel.text = (leaderboardData[row].guessingTimes)
            cell.answerLabel.text = leaderboardData[row].answer
            cell.dateLabel.text = leaderboardData[row].date
        case 1, 2, 3:
            style.firstThreeNumberStyle(cell.numberLabel)
            cell.numberLabel.text = "👑\(row)"
            cell.numberLabel.textColor = UIColor(named: "king")
            style.cellNumberLabelStyle(cell.numberLabel.layer)
            cell.secondLabel.text = "\(leaderboardData[row].second)秒"
            style.firstThreeNumberStyle(cell.secondLabel)
            cell.guessTimesLabel.text = "\(leaderboardData[row].guessingTimes)次"
            style.firstThreeNumberStyle(cell.guessTimesLabel)
            cell.answerLabel.text = leaderboardData[row].answer
            style.firstThreeNumberStyle(cell.answerLabel)
            cell.dateLabel.text = leaderboardData[row].date
            style.firstThreeNumberStyle(cell.dateLabel)
        default:
            cell.numberLabel.text = String(row)
            style.cellNumberLabelStyle(cell.numberLabel.layer)
            cell.secondLabel.text = "\(leaderboardData[row].second)秒"
            cell.guessTimesLabel.text = "\(leaderboardData[row].guessingTimes)次"
            cell.answerLabel.text = leaderboardData[row].answer
            cell.dateLabel.text = leaderboardData[row].date
        }
        return cell
    }
}
