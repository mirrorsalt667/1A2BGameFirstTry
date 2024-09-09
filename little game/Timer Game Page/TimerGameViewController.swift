//
//  TimerGameViewController.swift
//  little game
//
//  Created by Stephen on 2021/6/7.
//

import Foundation
import UIKit

final class TimerGameViewController: UIViewController {
    private let style = TimerGamePageStyle()
    private let model = GameModel()
    private let store = StoreLeaderboardModel()
    private let api = APIManager()
    private var timer: Timer?
    /// Show which number is the user guessing
    private var inputProcess = InputProcessModel(isFirstEmpty: true, isSecondEmpty: true, isThirdEmpty: true, isFourthEmpty: true)

    /// Show guessing times in a single game
    private var guessingTimes: Int = 0 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.gamingTimesLabel.text = "猜\(self.guessingTimes)次"
            }
        }
    }

    /// Show the time in a single game
    private var beginingSecond: Int = 0 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if self.beginingSecond == 0 {
                    self.countTimeLabel.text = "--秒"
                } else {
                    self.countTimeLabel.text = "\(self.beginingSecond)秒"
                }
            }
        }
    }

    /// Record answer the user guess in a round
    private var onceRecordNumbers = FourNumbersModel(firstNumber: 0, secondNumber: 0, thirdNumber: 0, fourthNumber: 0)

    /// Recording TextView on the left
    /// Can put 7 items in it
    private var recordArrayLeft = [String]()
    /// Recording TextView on the right
    private var recordArrayRight = [String]()

    /// is the game starting?
    private var isInGame = false
    /// leaderboard data
    private var records = [LeaderboardData]()

    // MARK: Components

    // Number Pad
    @IBOutlet private var number0Button: UIButton!
    @IBOutlet private var number1Button: UIButton!
    @IBOutlet private var number2Button: UIButton!
    @IBOutlet private var number3Button: UIButton!
    @IBOutlet private var number4Button: UIButton!
    @IBOutlet private var number5Button: UIButton!
    @IBOutlet private var number6Button: UIButton!
    @IBOutlet private var number7Button: UIButton!
    @IBOutlet private var number8Button: UIButton!
    @IBOutlet private var number9Button: UIButton!
    @IBOutlet private var pauseButton: UIButton!
    @IBOutlet private var keyBackButton: UIButton!

    // Labels
    @IBOutlet private var gamingTimesLabel: UILabel!
    @IBOutlet private var countTimeLabel: UILabel!
    @IBOutlet private var showNumberLabel1: UILabel!
    @IBOutlet private var showNumberLabel2: UILabel!
    @IBOutlet private var showNumberLabel3: UILabel!
    @IBOutlet private var showNumberLabel4: UILabel!
    @IBOutlet private var recordingNumberTextViewLeft: UITextView!
    @IBOutlet private var recordingNumberTextViewRight: UITextView!

    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setAppearanceAndInitial()
        let contents = generateRecord(recordArrayLeft, recordArrayRight)
        DispatchQueue.main.async {
            self.recordingNumberTextViewLeft.text = contents.0
            self.recordingNumberTextViewRight.text = contents.1
        }
        // 開始遊戲
        start()
        if timer != nil {
            timer?.invalidate()
        }
    }

    override func viewDidDisappear(_: Bool) {
        // stop timer when view disappear
        if timer != nil {
            timer?.invalidate()
        }
    }

    override func viewDidAppear(_: Bool) {
        if isInGame == true {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                self.beginingSecond += 1
            })
        }
    }
}

// MARK: - Methods

extension TimerGameViewController {
    private func setAppearanceAndInitial() {
        guessingTimes = 0
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

        style.textViewStyle(recordingNumberTextViewLeft.layer)
        style.textViewStyle(recordingNumberTextViewRight.layer)
        recordingNumberTextViewLeft.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        recordingNumberTextViewRight.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }

    /// number pad action
    private func keyInNumber(_ touchNumber: Int) {
        // which is empty
        if inputProcess.isFirstEmpty {
            inputProcess.isFirstEmpty = false
            style.fillLabelColor(showNumberLabel1, text: String(touchNumber))
            onceRecordNumbers.firstNumber = touchNumber
        } else if inputProcess.isSecondEmpty {
            inputProcess.isSecondEmpty = false
            style.fillLabelColor(showNumberLabel2, text: String(touchNumber))
            onceRecordNumbers.secondNumber = touchNumber
        } else if inputProcess.isThirdEmpty {
            inputProcess.isThirdEmpty = false
            style.fillLabelColor(showNumberLabel3, text: String(touchNumber))
            onceRecordNumbers.thirdNumber = touchNumber
        } else {
            inputProcess.isFourthEmpty = false
            style.fillLabelColor(showNumberLabel4, text: String(touchNumber))
            onceRecordNumbers.fourthNumber = touchNumber
            guessingTimes += 1
            let result = model.checkResponse(onceRecordNumbers)
            afterResult(result)
        }
    }

    /// delete the last move
    private func deleteNumber() {
        // which is empty
        if inputProcess.isFirstEmpty == false, inputProcess.isSecondEmpty == true {
            style.emptyLabelColor(showNumberLabel1)
            onceRecordNumbers.firstNumber = 0
            inputProcess.isFirstEmpty = true
        } else if inputProcess.isSecondEmpty == false, inputProcess.isThirdEmpty == true {
            style.emptyLabelColor(showNumberLabel2)
            onceRecordNumbers.secondNumber = 0
            inputProcess.isSecondEmpty = true
        } else if inputProcess.isThirdEmpty == false, inputProcess.isFourthEmpty == true {
            style.emptyLabelColor(showNumberLabel3)
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
            guard let answer = model.theAnswer else { return }
            let answerString = model.fourNumberToOneString(answer)
            let player = store.loadPlayerData()
            let mode = (guessingTimes == 1) ? 2 : 0
            if let player = player {
                let record = Leaderboards(id: 1, mode: mode, seconds: beginingSecond, times: String(guessingTimes), answer: answerString, timestamp: "", player_id: player.id, player_id_str: player.player_id_str, player_name: player.player_name)
                insertNewLeaderboardRecord(record)
            } else {
                print("<ERROR> Player doesn't exist")
                print("Create again")
                api.generateNewPlayer { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let player):
                        print("player id: \(player.player_id_str)")
                        self.store.savePlayerData(player)
                        if let newPlayer = self.store.loadPlayerData() {
                            let record = Leaderboards(id: 1, mode: mode, seconds: self.beginingSecond, times: String(self.guessingTimes), answer: answerString, timestamp: "", player_id: newPlayer.id, player_id_str: newPlayer.player_id_str, player_name: newPlayer.player_name)
                            self.insertNewLeaderboardRecord(record)
                        }
                    case .failure(let error):
                        print(">>> generate error: \(error)")
                        let errorMessage = error.localizedDescription
                        if errorMessage.contains("Could not connect to the server") {
                            self.alertWindow()
                        }
                    }
                }
            }

        case .defeat:
            print("Defeat! not happened in this mode.")

        case .continuing(let abCounter):
            // record on the board
            let recordText = "\(onceRecordNumbers.firstNumber)\(onceRecordNumbers.secondNumber)\(onceRecordNumbers.thirdNumber)\(onceRecordNumbers.fourthNumber) - \(abCounter.aCounter) A \(abCounter.bCounter) B"
            let leftLength = recordArrayLeft.count
            let rightLength = recordArrayRight.count
            if leftLength < 7 { // 7 in one column
                recordArrayLeft.insert(recordText, at: 0)
            } else {
                if rightLength >= 7 {
                    recordArrayRight.remove(at: 6)
                }
                recordArrayRight.insert(recordArrayLeft[6], at: 0)
                recordArrayLeft.remove(at: 6)
                recordArrayLeft.insert(recordText, at: 0)
            }

            let contents = generateRecord(recordArrayLeft, recordArrayRight)
            DispatchQueue.main.async {
                self.recordingNumberTextViewLeft.text = contents.0
                self.recordingNumberTextViewRight.text = contents.1
            }
            oneRoundReset()

        case .error(let errorType):
            print("<ERROR>: \(errorType)")
        }
    }

    /// Show alert window
    private func alertWindow() {
        let alert = UIAlertController(title: "連線錯誤", message: "伺服器連線失敗，暫時無法紀錄排行榜。", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    /// insert new leaderboard record
    func insertNewLeaderboardRecord(_ record: Leaderboards) {
        print(">>> Before insert: \(record)")
        api.insertLeaderboard(record) { result in
            switch result {
            case .success(let detial):
                print(">>> Insert new record success: \(detial)")
            case .failure(let error):
                print("<ERROR> \(error)")
            }
        }
    }

    // MARK: Game Start & Reset

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
        style.emptyLabelColor(showNumberLabel1)
        style.emptyLabelColor(showNumberLabel2)
        style.emptyLabelColor(showNumberLabel3)
        style.emptyLabelColor(showNumberLabel4)
        inputProcess = InputProcessModel(isFirstEmpty: true, isSecondEmpty: true, isThirdEmpty: true, isFourthEmpty: true)
        guessingTimes = 0
        beginingSecond = 0
        recordArrayLeft = []
        recordArrayRight = []
        let contents = generateRecord(recordArrayLeft, recordArrayRight)
        DispatchQueue.main.async {
            self.recordingNumberTextViewLeft.text = contents.0
            self.recordingNumberTextViewRight.text = contents.1
        }
    }

    /// One round game end
    private func oneRoundReset() {
        onceRecordNumbers = FourNumbersModel(firstNumber: 0, secondNumber: 0, thirdNumber: 0, fourthNumber: 0)
        inputProcess = InputProcessModel(isFirstEmpty: true, isSecondEmpty: true, isThirdEmpty: true, isFourthEmpty: true)
        style.emptyLabelColor(showNumberLabel1)
        style.emptyLabelColor(showNumberLabel2)
        style.emptyLabelColor(showNumberLabel3)
        style.emptyLabelColor(showNumberLabel4)
    }

    /// Show the victory window via an alart
    private func victoryWindow() {
        guard let answer = model.theAnswer else { return }
        let answerString = model.fourNumberToOneString(answer)
        let alert = UIAlertController(title: "正確", message: "答案：" + answerString + ", 時間：\(beginingSecond)秒", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    /// Reload the recording board
    /// RETURN: (left content, right content)
    private func generateRecord(_ left: [String], _ right: [String]) -> (String, String) {
        var leftContent = ""
        var rightContent = ""
        for item in left {
            leftContent = leftContent + item + "\n"
        }
        for item in right {
            rightContent = rightContent + item + "\n"
        }
        return (leftContent, rightContent)
    }
}

// MARK: - Button Action

extension TimerGameViewController {
    @IBAction private func resetButton(_: Any) {
        start()
    }

    @IBAction private func number0Button(_: Any) {
        if isInGame {
            keyInNumber(0)
        }
    }

    @IBAction private func number1Button(_: Any) {
        if isInGame {
            keyInNumber(1)
        }
    }

    @IBAction private func number2Button(_: Any) {
        if isInGame {
            keyInNumber(2)
        }
    }

    @IBAction private func number3Button(_: Any) {
        if isInGame {
            keyInNumber(3)
        }
    }

    @IBAction private func number4Button(_: Any) {
        if isInGame {
            keyInNumber(4)
        }
    }

    @IBAction private func number5Button(_: Any) {
        if isInGame {
            keyInNumber(5)
        }
    }

    @IBAction private func Number6Button(_: Any) {
        if isInGame {
            keyInNumber(6)
        }
    }

    @IBAction private func number7Button(_: Any) {
        if isInGame {
            keyInNumber(7)
        }
    }

    @IBAction private func number8Button(_: Any) {
        if isInGame {
            keyInNumber(8)
        }
    }

    @IBAction private func number9Button(_: Any) {
        if isInGame {
            keyInNumber(9)
        }
    }

    @IBAction private func keyBackButton(_: Any) {
        if isInGame {
            deleteNumber()
        }
    }
}
