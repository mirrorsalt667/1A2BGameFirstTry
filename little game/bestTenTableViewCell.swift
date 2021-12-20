//
//  bestTenTableViewCell.swift
//  little game
//
//  Created by 黃肇祺 on 2021/6/10.
//

import UIKit

class bestTenTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var guessTimesLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func labelLayout() {
        let cellView = self.contentView
        let width = self.contentView.frame.width //375
        //6間隔
        let widthArrays = [width/9, width/5, width/9, width/8, width/4]
        var leftWidth = CGFloat(0)
        var totalWidth = CGFloat(0)
        for k in 0..<widthArrays.count {
            totalWidth += widthArrays[k]
        }
        leftWidth = width - totalWidth
        let theLeftWidth = leftWidth/6
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
}
