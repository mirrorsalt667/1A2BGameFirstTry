//
//  LeaderboardCell.swift
//  little game
//
//  Created by Stephen on 2024/8/22.
//

import UIKit

final class LeaderboardCell: UITableViewCell {
    
    // MARK: Components
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var guessTimesLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    // Methods
    func labelLayout() {
        let cellView = contentView
        let width = contentView.frame.width
        // 6 gap
        let widthArrays = [width / 9, width / 5, width / 9, width / 8, width / 4]
        var leftWidth = CGFloat(0)
        var totalWidth = CGFloat(0)
        for k in 0 ..< widthArrays.count {
            totalWidth += widthArrays[k]
        }
        leftWidth = width - totalWidth
        let theLeftWidth = leftWidth / 6
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.widthAnchor.constraint(equalToConstant: widthArrays[0]).isActive = true
        numberLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: theLeftWidth).isActive = true
        numberLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true

        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.widthAnchor.constraint(equalToConstant: widthArrays[1]).isActive = true
        secondLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        secondLabel.leadingAnchor.constraint(equalTo: numberLabel.trailingAnchor, constant: theLeftWidth).isActive = true
        secondLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true

        guessTimesLabel.translatesAutoresizingMaskIntoConstraints = false
        guessTimesLabel.widthAnchor.constraint(equalToConstant: widthArrays[2]).isActive = true
        guessTimesLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        guessTimesLabel.leadingAnchor.constraint(equalTo: secondLabel.trailingAnchor, constant: theLeftWidth).isActive = true
        guessTimesLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true

        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.widthAnchor.constraint(equalToConstant: widthArrays[3]).isActive = true
        answerLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        answerLabel.leadingAnchor.constraint(equalTo: guessTimesLabel.trailingAnchor, constant: theLeftWidth).isActive = true
        answerLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.widthAnchor.constraint(equalToConstant: widthArrays[4]).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: answerLabel.trailingAnchor, constant: theLeftWidth).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
