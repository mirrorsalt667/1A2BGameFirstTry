//
//  Best10TableViewController.swift
//  little game
//
//  Created by 黃肇祺 on 2021/6/10.
//

import UIKit

class Best10TableViewController: UITableViewController {
    
    @IBOutlet weak var tableViewNavigation: UINavigationItem!
    
    var thisArrays: [bestRecordList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisArrays.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bestTenCell", for: indexPath) as! bestTenTableViewCell

        let row = indexPath.row
        cell.labelLayout()
        switch row {
        case 0:
            cell.numberLabel.text = ""
            cell.secondLabel.text = (thisArrays[row].second)
            cell.guessTimesLabel.text = (thisArrays[row].guess)
            cell.answerLabel.text = thisArrays[row].answer
            cell.dateLabel.text = thisArrays[row].date
        case 1, 2, 3:
            firstThreeOfNumberLabel(in: cell.numberLabel)
            cell.numberLabel.text = "👑\(row)"
            cell.numberLabel.textColor = UIColor(named: "king")
            firstThreeSet(in: cell.numberLabel.layer)
            cell.secondLabel.text = "\(thisArrays[row].second)秒"
            firstThreeOfNumberLabel(in: cell.secondLabel)
            cell.guessTimesLabel.text = "\(thisArrays[row].guess)次"
            firstThreeOfNumberLabel(in: cell.guessTimesLabel)
            cell.answerLabel.text = thisArrays[row].answer
            firstThreeOfNumberLabel(in: cell.answerLabel)
            cell.dateLabel.text = thisArrays[row].date
            firstThreeOfNumberLabel(in: cell.dateLabel)
        default:
            cell.numberLabel.text = String(row)
            cellNumberLabelSet(in: cell.numberLabel.layer)
            cell.secondLabel.text = "\(thisArrays[row].second)秒"
            cell.guessTimesLabel.text = "\(thisArrays[row].guess)次"
            cell.answerLabel.text = thisArrays[row].answer
            cell.dateLabel.text = thisArrays[row].date
        }
        
        return cell
    }
    
    func cellNumberLabelSet(in label: CALayer) {
        label.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
        label.borderWidth = 1
        label.cornerRadius = 3
        label.shadowRadius = 3
        label.shadowColor = UIColor.gray.cgColor
        label.shadowOffset = CGSize(width: 0.5, height: 0.5)
        label.shadowOpacity = 0.8
    }
    
    func firstThreeSet(in label: CALayer) {
        label.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
        label.borderWidth = 1
        label.cornerRadius = 3
    }
    
    func firstThreeOfNumberLabel(in label: UILabel) {
        label.font = UIFont.boldSystemFont(ofSize: 22)
    }

}
