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
    @IBOutlet var playerNameLabel: UILabel!
    @IBOutlet var playerIdLabel: UILabel!
    @IBOutlet var secondLabel: UILabel!
    @IBOutlet var guessTimesLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    // Methods
    func labelLayoutAndSetting() {
        let cellView = contentView
        let width = contentView.frame.width
        // 7 gaps
        let widths = [width / 9, width / 5, width / 5, width / 9, width / 8, width / 4]
        var leftWidth = CGFloat(0)
        var totalWidth = CGFloat(0)
        for item in widths {
            totalWidth += item
        }
        leftWidth = width - totalWidth
        let theLeftWidth = leftWidth / CGFloat(widths.count)
        
        var column = 0
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        numberLabel.widthAnchor.constraint(equalToConstant: widths[column]).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: theLeftWidth).isActive = true
        numberLabel.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        numberLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        numberLabel.textAlignment = .center
        numberLabel.numberOfLines = 0

        column = 1
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerNameLabel.widthAnchor.constraint(equalToConstant: widths[column]),
            playerNameLabel.heightAnchor.constraint(equalToConstant: 20),
            playerNameLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: theLeftWidth),
            playerNameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
        ])
        playerNameLabel.textAlignment = .center
        playerNameLabel.numberOfLines = 1
        playerNameLabel.adjustsFontSizeToFitWidth = true
        playerNameLabel.minimumScaleFactor = 0.5
        
        playerIdLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerIdLabel.widthAnchor.constraint(equalToConstant: widths[column]),
            playerIdLabel.heightAnchor.constraint(equalToConstant: 10),
            playerIdLabel.leftAnchor.constraint(equalTo: numberLabel.rightAnchor, constant: theLeftWidth),
            playerIdLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor),
            playerIdLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
        ])
        playerIdLabel.textAlignment = .center
        playerIdLabel.numberOfLines = 1
        playerIdLabel.font = UIFont.systemFont(ofSize: 12)

        column = 2
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.widthAnchor.constraint(equalToConstant: widths[column]).isActive = true
        secondLabel.leadingAnchor.constraint(equalTo: playerNameLabel.trailingAnchor, constant: theLeftWidth).isActive = true
        secondLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        secondLabel.textAlignment = .center
        secondLabel.numberOfLines = 0

        column = 3
        guessTimesLabel.translatesAutoresizingMaskIntoConstraints = false
        guessTimesLabel.widthAnchor.constraint(equalToConstant: widths[column]).isActive = true
        guessTimesLabel.leadingAnchor.constraint(equalTo: secondLabel.trailingAnchor, constant: theLeftWidth).isActive = true
        guessTimesLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        guessTimesLabel.textAlignment = .center
        guessTimesLabel.numberOfLines = 0

        column = 4
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.widthAnchor.constraint(equalToConstant: widths[column]).isActive = true
        answerLabel.leadingAnchor.constraint(equalTo: guessTimesLabel.trailingAnchor, constant: theLeftWidth).isActive = true
        answerLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        answerLabel.textAlignment = .center
        answerLabel.numberOfLines = 0

        column = 5
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.widthAnchor.constraint(equalToConstant: widths[column]).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: answerLabel.trailingAnchor, constant: theLeftWidth).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 0
    }

    func luckyShotLayoutAndSetting() {
        let cellView = contentView
        let width = contentView.frame.width
        // 4+1 gaps
        let widths = [0, width / 5, width / 5, 0, width / 5, width / 4]
        var leftWidth = CGFloat(0)
        var totalWidth = CGFloat(0)
        for item in widths {
            totalWidth += item
        }
        leftWidth = width - totalWidth
        let theLeftWidth = leftWidth / 5

        var column = 0
        numberLabel.isHidden = true

        column = 1
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerNameLabel.widthAnchor.constraint(equalToConstant: widths[column]),
            playerNameLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: theLeftWidth),
            playerNameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
        ])
        playerNameLabel.textAlignment = .center
        playerNameLabel.numberOfLines = 1
        playerNameLabel.adjustsFontSizeToFitWidth = true
        playerNameLabel.minimumScaleFactor = 0.5
        
        playerIdLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerIdLabel.widthAnchor.constraint(equalToConstant: widths[column]),
            playerIdLabel.heightAnchor.constraint(equalToConstant: 10),
            playerIdLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: theLeftWidth),
            playerIdLabel.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor),
            playerIdLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
        ])
        playerIdLabel.textAlignment = .center
        playerIdLabel.numberOfLines = 1
        playerIdLabel.font = UIFont.systemFont(ofSize: 12)

        column = 2
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabel.widthAnchor.constraint(equalToConstant: widths[column]),
            secondLabel.leftAnchor.constraint(equalTo: playerNameLabel.rightAnchor, constant: theLeftWidth),
            secondLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor)
        ])
        secondLabel.textAlignment = .center
        secondLabel.numberOfLines = 0

        column = 3
        guessTimesLabel.isHidden = true

        column = 4
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerLabel.widthAnchor.constraint(equalToConstant: widths[column]),
            answerLabel.leftAnchor.constraint(equalTo: secondLabel.rightAnchor, constant: theLeftWidth),
            answerLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
        ])
        answerLabel.textAlignment = .center
        answerLabel.numberOfLines = 0

        column = 5
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.widthAnchor.constraint(equalToConstant: widths[column]),
            dateLabel.leftAnchor.constraint(equalTo: answerLabel.rightAnchor, constant: theLeftWidth),
            dateLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
        ])
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 0
    }
}
