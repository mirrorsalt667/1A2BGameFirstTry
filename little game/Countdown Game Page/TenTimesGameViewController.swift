//
//  TenTimesGameViewController.swift
//  little game
//
//  Created by Stephen on 2021/6/16.
//

import UIKit

final class TenTimesGameViewController: UIViewController {
    private let style = TimerGamePageStyle()
    private let model = GameModel()
    private let store = StoreLeaderboardModel()
    private let api = APIManager()
    private var timer: Timer?

    // 只有十次機會，故顯示猜測欄位固定
    private var guessingArray: [NumbersAndAB] = []
    /// Record answer the user guess in a round
    private var onceRecordNumbers = FourNumbersModel(firstNumber: 0, secondNumber: 0, thirdNumber: 0, fourthNumber: 0)
    /// leaderboard data
    private var records = [LeaderboardData]()
    /// Show which number is the user guessing
    private var inputProcess = InputProcessModel(isFirstEmpty: true, isSecondEmpty: true, isThirdEmpty: true, isFourthEmpty: true)

    private var tenGuessingCounts = 10 {
        didSet {
            DispatchQueue.main.async {
                self.guessingTimesLabel.text = "剩\(self.tenGuessingCounts)次"
            }
        }
    }
    
    /// Show the time in a single game
    private var beginingSecond: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                if self.beginingSecond == 0 {
                    self.counterTimeLabel.text = "--秒"
                } else {
                    self.counterTimeLabel.text = "\(self.beginingSecond)秒"
                }
            }
        }
    }

    private var isInGame = false // 是否在遊戲中

    // MARK: - Components

    // tableView元件
    @IBOutlet var guessResultTableView: UITableView!

    /// Number Pad
    @IBOutlet var number1Button: UIButton!
    @IBOutlet var number2Button: UIButton!
    @IBOutlet var number3Button: UIButton!
    @IBOutlet var number4Button: UIButton!
    @IBOutlet var number5Button: UIButton!
    @IBOutlet var number6Button: UIButton!
    @IBOutlet var number7Button: UIButton!
    @IBOutlet var number8Button: UIButton!
    @IBOutlet var number9Button: UIButton!
    @IBOutlet var number0Button: UIButton!
    @IBOutlet var pauseButton: UIButton!
    @IBOutlet var keyBackButton: UIButton!

    /// Labels
    @IBOutlet var guessingTimesLabel: UILabel!
    @IBOutlet var counterTimeLabel: UILabel!
    @IBOutlet var showNumLabel1: UILabel!
    @IBOutlet var showNumLabel2: UILabel!
    @IBOutlet var showNumLabel3: UILabel!
    @IBOutlet var showNumLabel4: UILabel!

    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearanceAndInitial()

//        if let addBestArrays = storeModel.loadingSavedData(mode: .tenTimesMode) {
//            records = addBestArrays
//        }
//        
//        // 優先用秒數，次要用數字排序
//        records = storeModel.sortData(mode: .tenTimesMode, records)

        // 開始遊戲
        start()
        if timer != nil {
            timer?.invalidate()
        }
    }

    override func viewDidDisappear(_: Bool) {
        // 不在畫面內停止計時
        if timer != nil {
            timer?.invalidate()
        }
    }

    override func viewDidAppear(_: Bool) {
        // 若離開頁面又回來且在遊戲中，繼續計時
        if isInGame == true {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                self.beginingSecond += 1
            })
        }
    }
}

// MARK: - Methods

extension TenTimesGameViewController {
    private func setAppearanceAndInitial() {
        tenGuessingCounts = 10
        beginingSecond = 0
        
        style.numberButtonStyle(number1Button)
        style.numberButtonStyle(number2Button)
        style.numberButtonStyle(number3Button)
        style.numberButtonStyle(number4Button)
        style.numberButtonStyle(number5Button)
        style.numberButtonStyle(number6Button)
        style.numberButtonStyle(number7Button)
        style.numberButtonStyle(number8Button)
        style.numberButtonStyle(number9Button)
        style.numberButtonStyle(number0Button)
        style.numberButtonStyle(keyBackButton)
        style.numberButtonStyle(pauseButton)
    }
    
    /// number pad action
    private func keyInNumber(_ touchNumber: Int) {
        // which is empty
        if inputProcess.isFirstEmpty {
            inputProcess.isFirstEmpty = false
            style.fillLabelColor(showNumLabel1, text: String(touchNumber))
            onceRecordNumbers.firstNumber = touchNumber
        } else if inputProcess.isSecondEmpty {
            inputProcess.isSecondEmpty = false
            style.fillLabelColor(showNumLabel2, text: String(touchNumber))
            onceRecordNumbers.secondNumber = touchNumber
        } else if inputProcess.isThirdEmpty {
            inputProcess.isThirdEmpty = false
            style.fillLabelColor(showNumLabel3, text: String(touchNumber))
            onceRecordNumbers.thirdNumber = touchNumber
        } else {
            inputProcess.isFourthEmpty = false
            style.fillLabelColor(showNumLabel4, text: String(touchNumber))
            onceRecordNumbers.fourthNumber = touchNumber
            tenGuessingCounts -= 1
            let result = model.checkResponse(onceRecordNumbers)
            afterResult(result)
        }
    }
    
    /// delete the last move
    private func deleteNumber() {
        // which is empty
        if inputProcess.isFirstEmpty == false, inputProcess.isSecondEmpty == true {
            style.emptyLabelColor(showNumLabel1)
            onceRecordNumbers.firstNumber = 0
            inputProcess.isFirstEmpty = true
        } else if inputProcess.isSecondEmpty == false, inputProcess.isThirdEmpty == true {
            style.emptyLabelColor(showNumLabel2)
            onceRecordNumbers.secondNumber = 0
            inputProcess.isSecondEmpty = true
        } else if inputProcess.isThirdEmpty == false, inputProcess.isFourthEmpty == true {
            style.emptyLabelColor(showNumLabel3)
            onceRecordNumbers.thirdNumber = 0
            inputProcess.isThirdEmpty = true
        }
    }
    
    /// Doing action after get result of guessing
    private func afterResult(_ result: GameResult) {
        switch result {
        case .victory:
            victoryWindow()
            gameEnd()
            // leaderboard handling
            // 加入排行榜
            guard let answer = model.theAnswer else { return }
            let answerString = model.fourNumberToOneString(answer)
            let player = store.loadPlayerData()
            let mode = (tenGuessingCounts == 9) ? 2:1
            let record = Leaderboards(id: 1, mode: mode, seconds: beginingSecond, times: String(tenGuessingCounts), answer: answerString, timestamp: "", player_id: player?.id ?? 0, player_id_str: player?.player_id_str ?? "", player_name: player?.player_name ?? "NONE")
            print(">>> Before insert: \(record)")
            api.insertLeaderboard(record) { [weak self] result in
                switch result{
                case .success(let detial):
                    print(">>> Insert new record success: \(detial)")
                case .failure(let error):
                    print("<ERROR> \(error)")
                }
                // TODO: show score
            }
            //            let currentTime = model.getCurrentTime()
            //            records = storeModel.addNewRecord(mode: .tenTimesMode, LeaderboardData(second: String(beginingSecond), guessingTimes: String(tenGuessingCounts), answer: answerString, date: currentTime), records: records)
            //            // 儲存資料
            //            storeModel.saveData(mode: .tenTimesMode, records)
            
        case .defeat: // 不會發生
            defeatWindow()
            gameEnd()
            
        case let .continuing(abCounter):
            // record on the board
            let numberAB = NumbersAndAB(numbers: onceRecordNumbers, abs: abCounter)
            guessingArray.insert(numberAB, at: 0)
            guessResultTableView.reloadData()
            if tenGuessingCounts == 0 {
                // Defeat
                defeatWindow()
                gameEnd()
            } else {
                oneRoundReset()
            }
            
        case let .error(errorType):
            print("error: \(errorType)")
        }
    }
    
    // MARK: GameStart & reset
    
    /// Game Starting
    private func start() {
        isInGame = true
        // stop if it's counting
        timer?.invalidate()
        // create a random number
        model.creatingAnswer()
        // reset everything
        resetAll()
        // starting timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.beginingSecond += 1
        })
    }
    
    /// Game is over
    private func gameEnd() {
        timer?.invalidate()
        isInGame = false
    }
    
    /// Reset
    private func resetAll() {
        onceRecordNumbers = FourNumbersModel(firstNumber: 0, secondNumber: 0, thirdNumber: 0, fourthNumber: 0)
        style.emptyLabelColor(showNumLabel1)
        style.emptyLabelColor(showNumLabel2)
        style.emptyLabelColor(showNumLabel3)
        style.emptyLabelColor(showNumLabel4)
        inputProcess = InputProcessModel(isFirstEmpty: true, isSecondEmpty: true, isThirdEmpty: true, isFourthEmpty: true)
        tenGuessingCounts = 10
        beginingSecond = 0
        guessingArray = []
        guessResultTableView.reloadData()
    }
    
    /// One round game end
    private func oneRoundReset() {
        onceRecordNumbers = FourNumbersModel(firstNumber: 0, secondNumber: 0, thirdNumber: 0, fourthNumber: 0)
        inputProcess = InputProcessModel(isFirstEmpty: true, isSecondEmpty: true, isThirdEmpty: true, isFourthEmpty: true)
        style.emptyLabelColor(showNumLabel1)
        style.emptyLabelColor(showNumLabel2)
        style.emptyLabelColor(showNumLabel3)
        style.emptyLabelColor(showNumLabel4)
    }
    
    /// Show the victory window via an alart
    private func victoryWindow() {
        guard let answer = model.theAnswer else { return }
        let answerString = model.fourNumberToOneString(answer)
        let alert = UIAlertController(title: "正確", message: "答案：" + answerString + ", 時間：\(beginingSecond)秒", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func defeatWindow() {
        guard let answer = model.theAnswer else { return }
        let answerString = model.fourNumberToOneString(answer)
        let alertOver = UIAlertController(title: "次數用盡", message: "GG，答案：\(answerString)", preferredStyle: UIAlertController.Style.alert)
        alertOver.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertOver, animated: true, completion: nil)
    }
}

// MARK: - TableView

extension TenTimesGameViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        switch tenGuessingCounts {
        case 10: return 0
        case 9: return 1
        case 8: return 2
        case 7: return 3
        case 6: return 4
        case 5: return 5
        default: return 5
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TenTimesGameCell", for: indexPath) as! TenTimesGameTableViewCell
        let leftRow = indexPath.row
        let rightRow = leftRow + 5
        
        cell.guessing1Label.text = "\(guessingArray[leftRow].numbers.firstNumber)"
        cell.guessing2Label.text = "\(guessingArray[leftRow].numbers.secondNumber)"
        cell.guessing3Label.text = "\(guessingArray[leftRow].numbers.thirdNumber)"
        cell.guessing4Label.text = "\(guessingArray[leftRow].numbers.fourthNumber)"
        cell.aCounterLabel.text = "\(guessingArray[leftRow].abs.aCounter)"
        cell.aLabel.text = "A"
        cell.bCounterLabel.text = "\(guessingArray[leftRow].abs.bCounter)"
        cell.bLabel.text = "B"
        
        cell.addLabelStroke(cell.aCounterLabel.layer)
        cell.addLabelStroke(cell.bCounterLabel.layer)
        
        if tenGuessingCounts > 4 {
            cell.guessing1_1Label.text = ""
            cell.guessing2_1Label.text = ""
            cell.guessing3_1Label.text = ""
            cell.guessing4_1Label.text = ""
            cell.a_1counterLabel.text = ""
            cell.a_1Label.text = ""
            cell.b_1counterLabel.text = ""
            cell.b_1Label.text = ""
            
            cell.removeLabelStroke(cell.a_1counterLabel.layer)
            cell.removeLabelStroke(cell.b_1counterLabel.layer)
        } else {
            if rightRow >= guessingArray.count {
                cell.guessing1_1Label.text = ""
                cell.guessing2_1Label.text = ""
                cell.guessing3_1Label.text = ""
                cell.guessing4_1Label.text = ""
                cell.a_1counterLabel.text = ""
                cell.a_1Label.text = ""
                cell.b_1counterLabel.text = ""
                cell.b_1Label.text = ""
                
                cell.removeLabelStroke(cell.a_1counterLabel.layer)
                cell.removeLabelStroke(cell.b_1counterLabel.layer)
            } else {
                cell.guessing1_1Label.text = "\(guessingArray[rightRow].numbers.firstNumber)"
                cell.guessing2_1Label.text = "\(guessingArray[rightRow].numbers.secondNumber)"
                cell.guessing3_1Label.text = "\(guessingArray[rightRow].numbers.thirdNumber)"
                cell.guessing4_1Label.text = "\(guessingArray[rightRow].numbers.fourthNumber)"
                cell.a_1counterLabel.text = "\(guessingArray[rightRow].abs.aCounter)"
                cell.a_1Label.text = "A"
                cell.b_1counterLabel.text = "\(guessingArray[rightRow].abs.bCounter)"
                cell.b_1Label.text = "B"
                
                cell.addLabelStroke(cell.a_1counterLabel.layer)
                cell.addLabelStroke(cell.b_1counterLabel.layer)
            }
        }
        return cell
    }

    // 第一行淡入動畫
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0.05 * Double(0)) {
                cell.alpha = 1
            }
        }
    }
}

// MARK: - Button Action

extension TenTimesGameViewController {
    @IBAction func resetButton(_: Any) {
        start()
    }

    // 按鍵動作
    @IBAction func Number1Button(_: Any) {
        if isInGame {
            keyInNumber(1)
        }
    }

    @IBAction func Number2Button(_: Any) {
        if isInGame {
            keyInNumber(2)
        }
    }

    @IBAction func Number3Button(_: Any) {
        if isInGame {
            keyInNumber(3)
        }
    }

    @IBAction func Number4Button(_: Any) {
        if isInGame {
            keyInNumber(4)
        }
    }

    @IBAction func Number5Button(_: Any) {
        if isInGame {
            keyInNumber(5)
        }
    }

    @IBAction func Number6Button(_: Any) {
        if isInGame {
            keyInNumber(6)
        }
    }

    @IBAction func Number7Button(_: Any) {
        if isInGame {
            keyInNumber(7)
        }
    }

    @IBAction func Number8Button(_: Any) {
        if isInGame {
            keyInNumber(8)
        }
    }

    @IBAction func Number9Button(_: Any) {
        if isInGame {
            keyInNumber(9)
        }
    }
    
    @IBAction func Number0Button(_: Any) {
        if isInGame {
            keyInNumber(0)
        }
    }

    @IBAction func keyBackButton(_: Any) {
        if isInGame {
            deleteNumber()
        }
    }
}
