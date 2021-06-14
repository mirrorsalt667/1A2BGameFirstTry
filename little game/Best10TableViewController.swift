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
        if row == 0 {
            cell.numberLabel.text = ""
            cell.secondLabel.text = (thisArrays[row].second)
            cell.guessTimesLabel.text = (thisArrays[row].guess)
            cell.answerLabel.text = thisArrays[row].answer
            cell.dateLabel.text = thisArrays[row].date
        } else {
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
