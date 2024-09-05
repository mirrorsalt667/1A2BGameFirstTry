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
    @IBOutlet private var backButton: UIButton!
    @IBOutlet private var titleTextLabel: UILabel!
    
    // Variables
    
    private let style = LeaderboardStyle()
    private let apiRequest = APIManager()
    private let loadingView = LoadingView()
    private var timerLeaderboards = [Leaderboards]()
    private var countdownLeaderboards = [Leaderboards]()
    private var luckyLeaderboards = [Leaderboards]()
    private var mainDataSource = [Leaderboards]()
    var type: LeaderboardTypes?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getCurrentLeaderboards()
        DispatchQueue.main.async {
            self.backButton.setTitle("", for: .normal)
            self.titleTextLabel.font = UIFont.systemFont(ofSize: 20)
            switch self.type {
            case .none: self.titleTextLabel.text = ""
            case .some(.timer): self.titleTextLabel.text = "計時模式"
            case .some(.countdown): self.titleTextLabel.text = "次數模式"
            case .some(.lucky): self.titleTextLabel.text = "一次就猜中"
            }
        }
    }
    
    // MARK: - Methods
    
    private func getCurrentLeaderboards() {
        guard let type = type else { return }
        loadingView.showLoadingView(self.view)
        apiRequest.getLeaderboards(type: type) { [weak self] result in
            guard let self = self else {
                print("<ERROR> self doesn't exist")
                self?.loadingView.hidingLoadingView()
                return }
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
                self.mainDataSource = sortLeaderboard(self.type!, dataSource: self.mainDataSource)
                DispatchQueue.main.async {
                    self.loadingView.hidingLoadingView()
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.loadingView.hidingLoadingView()
                print(">>> Get Leaderboard Error: \(error)")
            }
        }
    }
    
    private func splitLeaderboardsViaMode(_ total: [Leaderboards]) -> ([Leaderboards], [Leaderboards], [Leaderboards]) {
        #if DEBUG
        print(">>> API DATA", total)
        #endif
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
    
    private func convertStringToDate(dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        // Set the date format according to the API response
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        // Convert the string to Date
        let date = dateFormatter.date(from: dateString)
        
        return date
    }
    
    func sortLeaderboard(_ type: LeaderboardTypes, dataSource: [Leaderboards]) -> [Leaderboards]{
        switch type {
        case .timer: // Less seconds, the better
            let sortedLeaderboards = dataSource.sorted {
                if $0.seconds == $1.seconds {
                    return Int($0.times)! < Int($1.times)!
                } else {
                    return $0.seconds < $1.seconds
                }
            }
            return sortedLeaderboards
        case .countdown: // More times left, the better
            let sortedLeaderboards = dataSource.sorted {
                if $0.times == $1.times {
                    return $0.seconds < $1.seconds
                } else {
                    return Int($0.times)! > Int($1.times)!
                }
            }
            return sortedLeaderboards
        case .lucky: // sort by timestamp
            let sortedLeaderboards = dataSource.sorted {
                let frontDate = convertStringToDate(dateString: $0.timestamp)!
                let LastDate = convertStringToDate(dateString: $1.timestamp)!
                return frontDate > LastDate
            }
            return sortedLeaderboards
        }
    }
}

// MARK: - Table View

extension LeaderboardViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainDataSource.count + 1 // because title is the first one
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as! LeaderboardCell
        let row = indexPath.row
        if type != .lucky {
            cell.labelLayoutAndSetting()
        } else {
            cell.luckyShotLayoutAndSetting()
        }
        switch row {
        case 0:
            cell.numberLabel.text = ""
            cell.playerNameLabel.text = "姓名"
            cell.playerIdLabel.text = ""
            cell.secondLabel.text = "時間"
            switch type {
            case .some(.timer):
                cell.guessTimesLabel.text = "猜"
            case .some(.countdown):
                cell.guessTimesLabel.text = "剩餘"
            case .some(.lucky):
                cell.guessTimesLabel.text = "次數"
            case .none:
                cell.guessTimesLabel.text = ""
            }
            cell.answerLabel.text = "答案"
            cell.dateLabel.text = "日期"
        case 1, 2, 3:
            if type != .lucky {
                cell.numberLabel.text = "👑\(row)"
                cell.numberLabel.textColor = UIColor(named: "king")
                style.cellNumberLabelStyle(cell.numberLabel.layer)
            } else {
                cell.numberLabel.text = "--"
            }
            cell.playerNameLabel.text = mainDataSource[row - 1].player_name
            cell.playerIdLabel.text = "#" + mainDataSource[row - 1].player_id_str
            cell.secondLabel.text = "\(mainDataSource[row - 1].seconds)秒"
            cell.guessTimesLabel.text = "\(mainDataSource[row - 1].times)次"
            cell.answerLabel.text = mainDataSource[row - 1].answer
            let timestampStr = mainDataSource[row - 1].timestamp
            if let theDate = convertStringToDate(dateString: timestampStr) {
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy/MM/dd"
                let str = dateFormat.string(from: theDate)
                cell.dateLabel.text = str
            }
        default:
            if type != .lucky {
                cell.numberLabel.text = String(row)
                style.cellNumberLabelStyle(cell.numberLabel.layer)
            } else {
                cell.numberLabel.text = "--"
            }
            cell.playerNameLabel.text = mainDataSource[row - 1].player_name
            cell.playerIdLabel.text = "#" + mainDataSource[row - 1].player_id_str
            cell.secondLabel.text = "\(mainDataSource[row - 1].seconds)秒"
            cell.guessTimesLabel.text = "\(mainDataSource[row - 1].times)次"
            cell.answerLabel.text = mainDataSource[row - 1].answer
            let timestampStr = mainDataSource[row - 1].timestamp
            if let theDate = convertStringToDate(dateString: timestampStr) {
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy/MM/dd"
                let str = dateFormat.string(from: theDate)
                cell.dateLabel.text = str
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
