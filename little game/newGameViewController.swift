//
//  newGameViewController.swift
//  little game
//
//  Created by 黃肇祺 on 2021/6/7.
//

import UIKit
import Foundation

class newGameViewController: UIViewController {
    
    var addBestRecordArrays: [bestRecordList] = [bestRecordList(second: "秒數", guess: "猜", answer: "答案", date: "日期"), ]

    
    
    //數字鍵盤
    @IBOutlet weak var Number1Button: UIButton!
    @IBOutlet weak var Number2Button: UIButton!
    @IBOutlet weak var Number3Button: UIButton!
    @IBOutlet weak var Number4Button: UIButton!
    @IBOutlet weak var Number5Button: UIButton!
    @IBOutlet weak var Number6Button: UIButton!
    @IBOutlet weak var Number7Button: UIButton!
    @IBOutlet weak var Number8Button: UIButton!
    @IBOutlet weak var Number9Button: UIButton!
    @IBOutlet weak var nonameButton: UIButton!
    @IBOutlet weak var Number0Button: UIButton!
    @IBOutlet weak var keyBackButton: UIButton!
    
    //顯示標籤
    @IBOutlet weak var GuessTImesLabel: UILabel!
    @IBOutlet weak var CountTimeLabel: UILabel!
    @IBOutlet weak var ShowNumLabel1: UILabel!
    @IBOutlet weak var ShowNumLabel2: UILabel!
    @IBOutlet weak var ShowNumLabel3: UILabel!
    @IBOutlet weak var ShowNumLabel4: UILabel!
    @IBOutlet weak var PassingGuessTextView1: UITextView!
    @IBOutlet weak var PassingGuessTextView2: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Label預設顯示文字
        loadingData()
        
        
        if let addBestArrays = loadingSavedData() {
            self.addBestRecordArrays = addBestArrays
        }
        //優先用秒數，次要用數字排序
        newArraysSetting()
        
        //設定外觀
        buttonContent(in: Number1Button)
        buttonContent(in: Number2Button)
        buttonContent(in: Number3Button)
        buttonContent(in: Number4Button)
        buttonContent(in: Number5Button)
        buttonContent(in: Number6Button)
        buttonContent(in: Number7Button)
        buttonContent(in: Number8Button)
        buttonContent(in: Number9Button)
        buttonContent(in: Number0Button)
        buttonContent(in: keyBackButton)
        buttonContent(in: nonameButton)

        textViewSet(in: PassingGuessTextView1.layer)
        textViewSet(in: PassingGuessTextView2.layer)
        self.PassingGuessTextView1.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        self.PassingGuessTextView2.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        //開始遊戲
        start()
        if timer != nil {
            timer?.invalidate()
        }
        
    }
    
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        //不在畫面內停止計時
        if timer != nil {
            timer?.invalidate()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        if inGameBool == true {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                self.startTime()
            })
        }
    }
    
    
    
    //Navigation Button items Action
    @IBAction func backFirstPageButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "backFirstPageSegue", sender: self)
    }
    
    
    @IBAction func bestTenButton(_ sender: Any) {
    }
    @IBAction func resetButton(_ sender: Any) {
        start()
    }
    
    //按鍵動作
    @IBAction func Number1Button(_ sender: Any) {
        if inGameBool == true {
            keyNumber = 1
            keyInNumber()
        }
    }
    @IBAction func Number2Button(_ sender: Any) {
        if inGameBool == true {
            keyNumber = 2
            keyInNumber()
        }
    }
    @IBAction func Number3Button(_ sender: Any) {
        if inGameBool == true {
            keyNumber = 3
            keyInNumber()
        }
    }
    @IBAction func Number4Button(_ sender: Any) {
        if inGameBool == true {
            keyNumber = 4
            keyInNumber()
        }
    }
    @IBAction func Number5Button(_ sender: Any) {
        if inGameBool == true {
            keyNumber = 5
            keyInNumber()
        }
    }
    @IBAction func Number6Button(_ sender: Any) {
        if inGameBool == true {
            keyNumber = 6
            keyInNumber()
        }
    }
    @IBAction func Number7Button(_ sender: Any) {
        if inGameBool == true {
            keyNumber = 7
            keyInNumber()
        }
    }
    @IBAction func Number8Button(_ sender: Any) {
        if inGameBool == true {
            keyNumber = 8
            keyInNumber()
        }
    }
    @IBAction func Number9Button(_ sender: Any) {
        if inGameBool == true {
            keyNumber = 9
            keyInNumber()
        }
    }
    @IBAction func nonameButton(_ sender: Any) {
        if inGameBool == true {
            //self.performSegue(withIdentifier: "pauseOne", sender: self)
        }
    }
    @IBAction func Number0Button(_ sender: Any) {
        if inGameBool == true {
            keyNumber = 0
            keyInNumber()
        }
    }
    @IBAction func keyBackButton(_ sender: Any) {
        if inGameBool == true {
            deleteAction()
        }
    }
}


extension newGameViewController {
  // MARK: Appearence setting
    func border(in layer: CALayer) {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
    //Button的設定
    func buttonContent(in button: UIButton) {
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.layer.backgroundColor = UIColor(named: "MorningGray")?.cgColor
        button.layer.cornerRadius = 7
        button.layer.shadowRadius = 7
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.layer.shadowColor = UIColor(named: "MorningBrown")?.cgColor
        button.layer.shadowOpacity = 1
    }
    
    //TextView
    func textViewSet(in layer: CALayer) {
        layer.cornerRadius = 18
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 18
        layer.shadowColor = UIColor(named: "MorningBlue3")?.cgColor
        layer.shadowOpacity = 1
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
    }
    
    //showNumberLabel
    func changeColor(in label: UILabel) {
        label.textColor = UIColor(named: "MorningOrange")
    }
    func changeBack(in label: UILabel) {
        label.textColor = UIColor(named: "MorningBlue3")
    }
    
    
    // MARK: - Function
    //Label預設顯示文字
    func loadingData() {
        GuessTImesLabel.text = "猜\(guessCounts)次"
        CountTimeLabel.text = "--秒"
        reloadGuessing()
    }
    
    
//ＢＵＴＴＯＮ ＡＣＴＩＯＮ
    // 數字鍵盤動作
    func keyInNumber() {
        if number1IsEmpty {
            ShowNumLabel1.text = String(keyNumber)
            guess1 = keyNumber
            changeColor(in: ShowNumLabel1)
            number1IsEmpty = false
        } else if number2IsEmpty {
            ShowNumLabel2.text = String(keyNumber)
            guess2 = keyNumber
            changeColor(in: ShowNumLabel2)
            number2IsEmpty = false
        } else if number3IsEmpty {
            ShowNumLabel3.text = String(keyNumber)
            guess3 = keyNumber
            changeColor(in: ShowNumLabel3)
            number3IsEmpty = false
        } else {
            ShowNumLabel4.text = String(keyNumber)
            guess4 = keyNumber
            changeColor(in: ShowNumLabel4)
            number4IsEmpty = false
            countGuessTimes()
            getResult()
        }
    }
    
    // 刪除鍵盤動作
    func deleteAction() {
        if number1IsEmpty == false && number2IsEmpty == true {
            ShowNumLabel1.text = String(0)
            guess1 = 0
            changeBack(in: ShowNumLabel1)
            number1IsEmpty = true
        } else if number2IsEmpty == false && number3IsEmpty == true {
            ShowNumLabel2.text = String(0)
            guess2 = 0
            changeBack(in: ShowNumLabel2)
            number2IsEmpty = true
        } else if number3IsEmpty == false && number4IsEmpty == true {
            ShowNumLabel3.text = String(0)
            guess3 = 0
            changeBack(in: ShowNumLabel3)
            number3IsEmpty = true
        } /*else if number4IsEmpty == false {
            ShowNumLabel4.text = String(0)
            guess4 = 0
            number4IsEmpty = true
        }*/
    }
    
    
//MARK: GameStart & reset
    
    //開始遊戲
    func start() {
        inGameBool = true
        //若在計時則先停止
        timer?.invalidate()
        //隨機選答案
        chooseAnswer()
        //所有東西初始化
        resetAll()
        //Label也初始化
        resetLabel()
        //計時器開始動
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            self.startTime()
        })
    }
    
    //計時開始
    func startTime() {
        beginingSecond += 1
        CountTimeLabel.text = "\(beginingSecond)秒"
    }
    
    //計算猜的次數
    func countGuessTimes() {
        guessCounts += 1
        GuessTImesLabel.text = "猜\(guessCounts)次"
    }
    
    //遊戲開始重置所有數字
    func resetAll() {
        guess1 = 0
        changeBack(in: ShowNumLabel1)
        guess2 = 0
        changeBack(in: ShowNumLabel2)
        guess3 = 0
        changeBack(in: ShowNumLabel3)
        guess4 = 0
        changeBack(in: ShowNumLabel4)
        number1IsEmpty = true
        number2IsEmpty = true
        number3IsEmpty = true
        number4IsEmpty = true
        countA = 0
        countB = 0
        guessCounts = 0
        
        guessArrays1 = ["", "", "", "", "", "", "", ]
        guessArrays2 = ["", "", "", "", "", "", "", ]
        
        beginingSecond = 0
    }
    
    //遊戲開始重置標籤Label
    func resetLabel() {
        ShowNumLabel1.text = String(0)
        ShowNumLabel2.text = String(0)
        ShowNumLabel3.text = String(0)
        ShowNumLabel4.text = String(0)
        reloadGuessing()
        GuessTImesLabel.text = "猜\(guessCounts)次"
        CountTimeLabel.text = "--秒"
    }
    
    
    //決定答案，避免數字重複
    func chooseAnswer() {
        answer1 = Int.random(in: 0...9)
        answer2 = Int.random(in: 0...9)
        while answer2 == answer1 { answer2 = Int.random(in: 0...9) }
        answer3 = Int.random(in: 0...9)
        while answer3 == answer2 || answer3 == answer1 { answer3 = Int.random(in: 0...9) }
        answer4 = Int.random(in: 0...9)
        while answer4 == answer3 || answer4 == answer2 || answer4 == answer1 { answer4 = Int.random(in: 0...9) }
    }
    
    //計算答案使否相符
    func getResult() {
        switch  answer1 {
        case guess1: countA += 1
        case guess2, guess3, guess4: countB += 1
        default: break
        }
        switch  answer2 {
        case guess2: countA += 1
        case guess1, guess3, guess4: countB += 1
        default: break
        }
        switch  answer3 {
        case guess3: countA += 1
        case guess1, guess2, guess4: countB += 1
        default: break
        }
        switch  answer4 {
        case guess4: countA += 1
        case guess1, guess2, guess3: countB += 1
        default: break
        }
        //顯示猜測結果
        if countA == 4 { //答對了
            //停止計時，顯示答對了
            timer?.invalidate()
            inGameBool = false
            getRight()
            //記錄時間
            let currectTime = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY/MM/dd"
            let getDate = dateFormatter.string(from: currectTime)
            currectTime1 = getDate
            //加入排行榜
            theBestRecord()
            //儲存資料
            saveData()
            
        } else {
            guessArrays2.insert(guessArrays1[6], at: 0)
            guessArrays2.remove(at: 7)
            guessArrays1.insert("\(guess1)\(guess2)\(guess3)\(guess4) - \(countA) A \(countB) B\n", at: 0)
            guessArrays1.remove(at: 7)
            reloadGuessing()
            //重猜
            countA = 0
            countB = 0
            guess1 = 0
            changeBack(in: ShowNumLabel1)
            guess2 = 0
            changeBack(in: ShowNumLabel2)
            guess3 = 0
            changeBack(in: ShowNumLabel3)
            guess4 = 0
            changeBack(in: ShowNumLabel4)
            number1IsEmpty = true
            number2IsEmpty = true
            number3IsEmpty = true
            number4IsEmpty = true
            ShowNumLabel1.text = String(0)
            ShowNumLabel2.text = String(0)
            ShowNumLabel3.text = String(0)
            ShowNumLabel4.text = String(0)
        }
    }
    
    func getRight() {
            //顯示答對視窗
        let alert = UIAlertController(title: "答對了唷", message: "答案：\(answer1)\(answer2)\(answer3)\(answer4), 時間：\(beginingSecond)秒", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "太棒了！", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    //刷新猜測數字
    func reloadGuessing() {
        PassingGuessTextView1.text = "\(guessArrays1[0])\(guessArrays1[1])\(guessArrays1[2])\(guessArrays1[3])\(guessArrays1[4])\(guessArrays1[5])\(guessArrays1[6])"
        PassingGuessTextView2.text = "\(guessArrays2[0])\(guessArrays2[1])\(guessArrays2[2])\(guessArrays2[3])\(guessArrays2[4])\(guessArrays2[5])\(guessArrays2[6])"
    }
    
    //答對－計入排行榜
    func theBestRecord() {
        //let newRecord = ["\(beginingSecond)", "\(guessCounts)", "\(answer1)\(answer2)\(answer3)\(answer4)", "\(currectTime1)"]
        let arraysNumber = addBestRecordArrays.count
        //let row = arraysNumber - 1
        //如果只有一個就直接加入
        if arraysNumber == 1 {
            addBestRecordArrays.insert(contentsOf: [bestRecordList(second: "\(beginingSecond)", guess: "\(guessCounts)", answer: "\(answer1)\(answer2)\(answer3)\(answer4)", date: "\(currectTime1)")], at: arraysNumber)
        }//兩個以上要比大小，超過十個刪除最後一個
        else if arraysNumber > 1 && arraysNumber < 21 {
                addBestRecordArrays.insert(contentsOf: [bestRecordList(second: "\(beginingSecond)", guess: "\(guessCounts)", answer: "\(answer1)\(answer2)\(answer3)\(answer4)", date: "\(currectTime1)")], at: arraysNumber)
                addBestRecordArrays.sort { arrays1, arrays2 in
                    return arrays1.second.compare(arrays2.second, options: .numeric) == .orderedAscending
                }
            addBestRecordArrays.sort { array_1, array_2 in
                return array_1.second.compare(array_2.second, options: .numeric) == .orderedSame
            }
            
                //排序後 將標題列移回第一行
                let newCount = addBestRecordArrays.count
                let newRow = newCount - 1
                let arrayTitle = addBestRecordArrays[newRow]
                addBestRecordArrays.insert(arrayTitle, at: 0)
                addBestRecordArrays.remove(at: newCount)
        }
                //若超過前十名，比大小，贏的才納入，並刪除第11名
        else if arraysNumber == 21 {
            let row = arraysNumber - 1
            if beginingSecond < Int(addBestRecordArrays[row].second) ?? 0 {
                addBestRecordArrays.insert(contentsOf: [bestRecordList(second: "\(beginingSecond)", guess: "\(guessCounts)", answer: "\(answer1)\(answer2)\(answer3)\(answer4)", date: "\(currectTime1)")], at: arraysNumber)
                addBestRecordArrays.sort { arrays1, arrays2 in
                    return arrays1.second.compare(arrays2.second, options: .numeric) == .orderedAscending
                }
                addBestRecordArrays.sort { array_1, array_2 in
                    return array_1.second.compare(array_2.second, options: .numeric) == .orderedSame
                }
                
                //排序後 將標題列移回第一行
                let newCount = addBestRecordArrays.count
                let newRow = newCount - 1
                let arrayTitle = addBestRecordArrays[newRow]
                addBestRecordArrays.insert(arrayTitle, at: 0)
                addBestRecordArrays.remove(at: newCount)
                //將第11名刪掉
                addBestRecordArrays.remove(at: 21)
                
            }
        }
    }
    // 增加排序參數
    func newArraysSetting() {
        addBestRecordArrays.sort { arrays1, arrays2 in
            return arrays1.second.compare(arrays2.second, options: .numeric) == .orderedAscending
        }
        addBestRecordArrays.sort { array_1, array_2 in
            return array_1.second.compare(array_2.second, options: .numeric) == .orderedSame
        }
    
        //排序後 將標題列移回第一行
        let newCount = addBestRecordArrays.count
        let newRow = newCount - 1
        let arrayTitle = addBestRecordArrays[newRow]
        addBestRecordArrays.insert(arrayTitle, at: 0)
        addBestRecordArrays.remove(at: newCount)
    }
    
    
    
    //儲存排行榜資料
    func saveData() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(addBestRecordArrays)  else { return }
        let userDefault = UserDefaults.standard
        userDefault.set(data, forKey: "bestRecordData")
    }
    
    //讀取儲存的資料
    func loadingSavedData() -> [bestRecordList]? {
        let userDefault = UserDefaults.standard
        guard let data = userDefault.data(forKey: "bestRecordData") else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([bestRecordList].self, from: data)
    }
    
    
    
// MARK: - prepare
    // 傳資料到排行榜頁面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? Best10TableViewController {
            controller.thisArrays = addBestRecordArrays
        }
    }
    
}
