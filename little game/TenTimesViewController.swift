//
//  TenTimesViewController.swift
//  little game
//
//  Created by Stephen on 2021/6/16.
//

import UIKit


class TenTimesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //紀錄陣列匯出到排行榜頁面
    var addTenTimesRecordArrays: [bestRecordList] = [bestRecordList(second: "時間", guess: "剩餘", answer: "答案", date: "日期"), ]
    //更新表格標題
    let newTitle = [bestRecordList(second: "秒數", guess: "剩餘", answer: "答案", date: "日期"), ]
    
    //只有十次機會，故顯示猜測欄位固定
    var guessArrays_Ten: [tenArrays] = []
    
    var tenGuessCounts = 10 //倒數十次
    
    var tenInGame = false //是否在遊戲中
    
    //MARK: tableView
    //設定tableView顯示
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tenGuessCounts {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "tenTimesCell", for: indexPath) as! TenTableViewCell
        
        //色彩邊框
        func labelSetting(in layer: CALayer) {
            layer.cornerRadius = 2
            layer.borderWidth = 1
            layer.borderColor = UIColor(named: "MorningDarkGreen")?.cgColor
        }
        
        func loseColor(in layer: CALayer) {
            layer.borderWidth = 0
        }
        
        
        // 安排每個答案的func
        func doNotHave() {
            cell.guess1_1Label.text = ""
            cell.guess2_1Label.text = ""
            cell.guess3_1Label.text = ""
            cell.guess4_1Label.text = ""
            cell.A_1countLabel.text = ""
            cell.A_1Label.text = ""
            cell.B_1countLabel.text = ""
            cell.B_1Label.text = ""
            loseColor(in: cell.A_1countLabel.layer)
            loseColor(in: cell.B_1countLabel.layer)
        }
        func theAnswerOne() {
            cell.guess1Label.text = "\(guessArrays_Ten[0].one)"
            cell.guess2Label.text = "\(guessArrays_Ten[0].two)"
            cell.guess3Label.text = "\(guessArrays_Ten[0].three)"
            cell.guess4Label.text = "\(guessArrays_Ten[0].four)"
            cell.AcountLabel.text = "\(guessArrays_Ten[0].aNum)"
            cell.ALabel.text = "A"
            cell.BcountLabel.text = "\(guessArrays_Ten[0].bNum)"
            cell.BLabel.text = "B"
            
            //樣式
            labelSetting(in: cell.AcountLabel.layer)
            labelSetting(in: cell.BcountLabel.layer)
        }
        func theAnswerTwo() {
            cell.guess1Label.text = "\(guessArrays_Ten[1].one)"
            cell.guess2Label.text = "\(guessArrays_Ten[1].two)"
            cell.guess3Label.text = "\(guessArrays_Ten[1].three)"
            cell.guess4Label.text = "\(guessArrays_Ten[1].four)"
            cell.AcountLabel.text = "\(guessArrays_Ten[1].aNum)"
            cell.ALabel.text = "A"
            cell.BcountLabel.text = "\(guessArrays_Ten[1].bNum)"
            cell.BLabel.text = "B"
        }
        func theAnswerThree() {
            cell.guess1Label.text = "\(guessArrays_Ten[2].one)"
            cell.guess2Label.text = "\(guessArrays_Ten[2].two)"
            cell.guess3Label.text = "\(guessArrays_Ten[2].three)"
            cell.guess4Label.text = "\(guessArrays_Ten[2].four)"
            cell.AcountLabel.text = "\(guessArrays_Ten[2].aNum)"
            cell.ALabel.text = "A"
            cell.BcountLabel.text = "\(guessArrays_Ten[2].bNum)"
            cell.BLabel.text = "B"
        }
        func theAnswerFour() {
            cell.guess1Label.text = "\(guessArrays_Ten[3].one)"
            cell.guess2Label.text = "\(guessArrays_Ten[3].two)"
            cell.guess3Label.text = "\(guessArrays_Ten[3].three)"
            cell.guess4Label.text = "\(guessArrays_Ten[3].four)"
            cell.AcountLabel.text = "\(guessArrays_Ten[3].aNum)"
            cell.ALabel.text = "A"
            cell.BcountLabel.text = "\(guessArrays_Ten[3].bNum)"
            cell.BLabel.text = "B"
        }
        func theAnswerFive() {
            cell.guess1Label.text = "\(guessArrays_Ten[4].one)"
            cell.guess2Label.text = "\(guessArrays_Ten[4].two)"
            cell.guess3Label.text = "\(guessArrays_Ten[4].three)"
            cell.guess4Label.text = "\(guessArrays_Ten[4].four)"
            cell.AcountLabel.text = "\(guessArrays_Ten[4].aNum)"
            cell.ALabel.text = "A"
            cell.BcountLabel.text = "\(guessArrays_Ten[4].bNum)"
            cell.BLabel.text = "B"
        }
        func theAnswerSix() {
            cell.guess1Label.text = "\(guessArrays_Ten[5].one)"
            cell.guess2Label.text = "\(guessArrays_Ten[5].two)"
            cell.guess3Label.text = "\(guessArrays_Ten[5].three)"
            cell.guess4Label.text = "\(guessArrays_Ten[5].four)"
            cell.AcountLabel.text = "\(guessArrays_Ten[5].aNum)"
            cell.ALabel.text = "A"
            cell.BcountLabel.text = "\(guessArrays_Ten[5].bNum)"
            cell.BLabel.text = "B"
        }
        func theAnswerSeven() {
            cell.guess1Label.text = "\(guessArrays_Ten[6].one)"
            cell.guess2Label.text = "\(guessArrays_Ten[6].two)"
            cell.guess3Label.text = "\(guessArrays_Ten[6].three)"
            cell.guess4Label.text = "\(guessArrays_Ten[6].four)"
            cell.AcountLabel.text = "\(guessArrays_Ten[6].aNum)"
            cell.ALabel.text = "A"
            cell.BcountLabel.text = "\(guessArrays_Ten[6].bNum)"
            cell.BLabel.text = "B"
        }
        func theAnswerEight() {
            cell.guess1Label.text = "\(guessArrays_Ten[7].one)"
            cell.guess2Label.text = "\(guessArrays_Ten[7].two)"
            cell.guess3Label.text = "\(guessArrays_Ten[7].three)"
            cell.guess4Label.text = "\(guessArrays_Ten[7].four)"
            cell.AcountLabel.text = "\(guessArrays_Ten[7].aNum)"
            cell.ALabel.text = "A"
            cell.BcountLabel.text = "\(guessArrays_Ten[7].bNum)"
            cell.BLabel.text = "B"
        }
        func theAnswerNine() {
            cell.guess1Label.text = "\(guessArrays_Ten[8].one)"
            cell.guess2Label.text = "\(guessArrays_Ten[8].two)"
            cell.guess3Label.text = "\(guessArrays_Ten[8].three)"
            cell.guess4Label.text = "\(guessArrays_Ten[8].four)"
            cell.AcountLabel.text = "\(guessArrays_Ten[8].aNum)"
            cell.ALabel.text = "A"
            cell.BcountLabel.text = "\(guessArrays_Ten[8].bNum)"
            cell.BLabel.text = "B"
        }
        func theAnswerTen() {
            cell.guess1Label.text = "\(guessArrays_Ten[9].one)"
            cell.guess2Label.text = "\(guessArrays_Ten[9].two)"
            cell.guess3Label.text = "\(guessArrays_Ten[9].three)"
            cell.guess4Label.text = "\(guessArrays_Ten[9].four)"
            cell.AcountLabel.text = "\(guessArrays_Ten[9].aNum)"
            cell.ALabel.text = "A"
            cell.BcountLabel.text = "\(guessArrays_Ten[9].bNum)"
            cell.BLabel.text = "B"
        }
        func theAnswer_One() {
            cell.guess1_1Label.text = "\(guessArrays_Ten[0].one)"
            cell.guess2_1Label.text = "\(guessArrays_Ten[0].two)"
            cell.guess3_1Label.text = "\(guessArrays_Ten[0].three)"
            cell.guess4_1Label.text = "\(guessArrays_Ten[0].four)"
            cell.A_1countLabel.text = "\(guessArrays_Ten[0].aNum)"
            cell.A_1Label.text = "A"
            cell.B_1countLabel.text = "\(guessArrays_Ten[0].bNum)"
            cell.B_1Label.text = "B"
            
            //樣式
            labelSetting(in: cell.A_1countLabel.layer)
            labelSetting(in: cell.B_1countLabel.layer)
        }
        func theAnswer_Two() {
            cell.guess1_1Label.text = "\(guessArrays_Ten[1].one)"
            cell.guess2_1Label.text = "\(guessArrays_Ten[1].two)"
            cell.guess3_1Label.text = "\(guessArrays_Ten[1].three)"
            cell.guess4_1Label.text = "\(guessArrays_Ten[1].four)"
            cell.A_1countLabel.text = "\(guessArrays_Ten[1].aNum)"
            cell.A_1Label.text = "A"
            cell.B_1countLabel.text = "\(guessArrays_Ten[1].bNum)"
            cell.B_1Label.text = "B"
        }
        func theAnswer_Three() {
            cell.guess1_1Label.text = "\(guessArrays_Ten[2].one)"
            cell.guess2_1Label.text = "\(guessArrays_Ten[2].two)"
            cell.guess3_1Label.text = "\(guessArrays_Ten[2].three)"
            cell.guess4_1Label.text = "\(guessArrays_Ten[2].four)"
            cell.A_1countLabel.text = "\(guessArrays_Ten[2].aNum)"
            cell.A_1Label.text = "A"
            cell.B_1countLabel.text = "\(guessArrays_Ten[2].bNum)"
            cell.B_1Label.text = "B"
        }
        func theAnswer_Four() {
            cell.guess1_1Label.text = "\(guessArrays_Ten[3].one)"
            cell.guess2_1Label.text = "\(guessArrays_Ten[3].two)"
            cell.guess3_1Label.text = "\(guessArrays_Ten[3].three)"
            cell.guess4_1Label.text = "\(guessArrays_Ten[3].four)"
            cell.A_1countLabel.text = "\(guessArrays_Ten[3].aNum)"
            cell.A_1Label.text = "A"
            cell.B_1countLabel.text = "\(guessArrays_Ten[3].bNum)"
            cell.B_1Label.text = "B"
        }
        func theAnswer_Five() {
            cell.guess1_1Label.text = "\(guessArrays_Ten[4].one)"
            cell.guess2_1Label.text = "\(guessArrays_Ten[4].two)"
            cell.guess3_1Label.text = "\(guessArrays_Ten[4].three)"
            cell.guess4_1Label.text = "\(guessArrays_Ten[4].four)"
            cell.A_1countLabel.text = "\(guessArrays_Ten[4].aNum)"
            cell.A_1Label.text = "A"
            cell.B_1countLabel.text = "\(guessArrays_Ten[4].bNum)"
            cell.B_1Label.text = "B"
        }
        
        //cell的行數
        let row = indexPath.row
        
        //使答案遺延下去
        switch tenGuessCounts {
        case 9:
            if row == 0 {
                theAnswerOne()
                doNotHave()
            }
        case 8:
            if row == 0 {
                theAnswerTwo()
                doNotHave()
            }
            if row == 1 {
                theAnswerOne()
                doNotHave()
            }
        case 7:
            if row == 0 {
                theAnswerThree()
                doNotHave()
            }
            if row == 1 {
                theAnswerTwo()
                doNotHave()
            }
            if row == 2 {
                theAnswerOne()
                doNotHave()
            }
        case 6:
            if row == 0 {
                theAnswerFour()
                doNotHave()
            }
            if row == 1 {
                theAnswerThree()
                doNotHave()
            }
            if row == 2 {
                theAnswerTwo()
                doNotHave()
            }
            if row == 3 {
                theAnswerOne()
                doNotHave()
            }
        case 5:
            if row == 0 {
                theAnswerFive()
                doNotHave()
            }
            if row == 1 {
                theAnswerFour()
                doNotHave()
            }
            if row == 2 {
                theAnswerThree()
                doNotHave()
            }
            if row == 3 {
                theAnswerTwo()
                doNotHave()
            }
            if row == 4 {
                theAnswerOne()
                doNotHave()
            }
        case 4:
            if row == 0 {
                theAnswerSix()
                theAnswer_One()
            }
            if row == 1 {
                theAnswerFive()
                doNotHave()
            }
            if row == 2 {
                theAnswerFour()
                doNotHave()
            }
            if row == 3 {
                theAnswerThree()
                doNotHave()
            }
            if row == 4 {
                theAnswerTwo()
                doNotHave()
            }
        case 3:
            if row == 0 {
                theAnswerSeven()
                theAnswer_Two()
            }
            if row == 1 {
                theAnswerSix()
                theAnswer_One()
            }
            if row == 2 {
                theAnswerFive()
                doNotHave()
            }
            if row == 3 {
                theAnswerFour()
                doNotHave()
            }
            if row == 4 {
                theAnswerThree()
                doNotHave()
            }
        case 2:
            if row == 0 {
                theAnswerEight()
                theAnswer_Three()
            }
            if row == 1 {
                theAnswerSeven()
                theAnswer_Two()
            }
            if row == 2 {
                theAnswerSix()
                theAnswer_One()
            }
            if row == 3 {
                theAnswerFive()
                doNotHave()
            }
            if row == 4 {
                theAnswerFour()
                doNotHave()
            }
        case 1:
            if row == 0 {
                theAnswerNine()
                theAnswer_Four()
            }
            if row == 1 {
                theAnswerEight()
                theAnswer_Three()
            }
            if row == 2 {
                theAnswerSeven()
                theAnswer_Two()
            }
            if row == 3 {
                theAnswerSix()
                theAnswer_One()
            }
            if row == 4 {
                theAnswerFive()
                doNotHave()
            }
        case 0:
            if row == 0 {
                theAnswerTen()
                theAnswer_Five()
            }
            if row == 1 {
                theAnswerNine()
                theAnswer_Four()
            }
            if row == 2 {
                theAnswerEight()
                theAnswer_Three()
            }
            if row == 3 {
                theAnswerSeven()
                theAnswer_Two()
            }
            if row == 4 {
                theAnswerSix()
                theAnswer_One()
            }
        default: break }
        return cell
    }
    
    
    //第一行淡入動畫
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row ==  0 {
            cell.alpha = 0
            UIView.animate(withDuration: 0.5, delay: 0.05 * Double(0)) {
                cell.alpha = 1
            }
        }
    }
    
    
    //MARK: Outlet
    //tableView元件
    @IBOutlet weak var guessResultTableView: UITableView!
    
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
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Label預設顯示文字
        loadingData()
        
        
        if let addBestArrays = loadingSavedData() {
            self.addTenTimesRecordArrays = addBestArrays
        }
        
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
        //若離開頁面又回來且在遊戲中，繼續計時
        if tenInGame == true {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
                self.startTime()
            })
        }
    }
    
    
//MARK: Button

    //Navigation Button items Action
    @IBAction func backFirstPageButton(_ sender: Any) {
        self.performSegue(withIdentifier: "tenBackFirstSegue", sender: self)
    }
    
    @IBAction func bestTenButton(_ sender: Any) {
    }
    @IBAction func resetButton(_ sender: Any) {
        start()
    }
    
    //按鍵動作
    @IBAction func Number1Button(_ sender: Any) {
        if tenInGame == true {
            keyNumber = 1
            keyInNumber()
        }
    }
    @IBAction func Number2Button(_ sender: Any) {
        if tenInGame == true {
            keyNumber = 2
            keyInNumber()
        }
    }
    @IBAction func Number3Button(_ sender: Any) {
        if tenInGame == true {
            keyNumber = 3
            keyInNumber()
        }
    }
    @IBAction func Number4Button(_ sender: Any) {
        if tenInGame == true {
            keyNumber = 4
            keyInNumber()
        }
    }
    @IBAction func Number5Button(_ sender: Any) {
        if tenInGame == true {
            keyNumber = 5
            keyInNumber()
        }
    }
    @IBAction func Number6Button(_ sender: Any) {
        if tenInGame == true {
            keyNumber = 6
            keyInNumber()
        }
    }
    @IBAction func Number7Button(_ sender: Any) {
        if tenInGame == true {
            keyNumber = 7
            keyInNumber()
        }
    }
    @IBAction func Number8Button(_ sender: Any) {
        if tenInGame == true {
            keyNumber = 8
            keyInNumber()
        }
    }
    @IBAction func Number9Button(_ sender: Any) {
        if tenInGame == true {
            keyNumber = 9
            keyInNumber()
        }
    }
    @IBAction func nonameButton(_ sender: Any) {
        if tenInGame == true {
           // self.performSegue(withIdentifier: "pauseTwo", sender: self)
        }
    }
    @IBAction func Number0Button(_ sender: Any) {
        if tenInGame == true {
            keyNumber = 0
            keyInNumber()
        }
    }
    @IBAction func keyBackButton(_ sender: Any) {
        if tenInGame == true {
            deleteAction()
        }
    }
}


//自訂猜的陣列型別，於Label顯示
struct tenArrays {
    var one: Int
    var two: Int
    var three: Int
    var four: Int
    var aNum: Int
    var bNum: Int
    
}




extension TenTimesViewController {
    // MARK: Appearence setting
    
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
        GuessTImesLabel.text = "剩\(tenGuessCounts)次"
        CountTimeLabel.text = "0秒"
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
        }
    }
    
    
    //MARK: GameStart & reset
    
    //開始遊戲
    func start() {
        tenInGame = true
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
        tenGuessCounts -= 1
        GuessTImesLabel.text = "剩\(tenGuessCounts)次"
    }
    
    //到10次都沒解出來，遊戲結束
    
    
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
        tenGuessCounts = 10
        
        beginingSecond = 0
    }
    
    //遊戲開始重置標籤Label
    func resetLabel() {
        ShowNumLabel1.text = String(0)
        ShowNumLabel2.text = String(0)
        ShowNumLabel3.text = String(0)
        ShowNumLabel4.text = String(0)
        
        GuessTImesLabel.text = "剩\(tenGuessCounts)次"
        CountTimeLabel.text = "0秒"
        
        guessArrays_Ten = []
        guessResultTableView.reloadData()
        
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
        let newMember = [tenArrays(one: guess1, two: guess2, three: guess3, four: guess4, aNum: countA, bNum: countB)]
        guessArrays_Ten.append(contentsOf: newMember)
        guessResultTableView.reloadData()
        if countA == 4 { //答對了
            //停止計時，顯示答對了
            timer?.invalidate()
            tenInGame = false
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
            if tenGuessCounts != 0 {
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
            } else {
                //10次都沒猜對
                timer?.invalidate()
                tenInGame = false
                //顯示遊戲結束
                gameOver()
            }
        }
    }
    
    func getRight() {
        //顯示答對視窗
        let alert = UIAlertController(title: "答對了唷", message: "答案：\(answer1)\(answer2)\(answer3)\(answer4), 時間：\(beginingSecond)秒", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "太棒了！", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func gameOver() {
        //顯示結束視窗
        let alertOver = UIAlertController(title: "次數用盡", message: "GG，答案：\(answer1)\(answer2)\(answer3)\(answer4)", preferredStyle: UIAlertController.Style.alert)
        alertOver.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alertOver, animated: true, completion: nil)
    }
    
    
    //答對－計入排行榜
    func theBestRecord() {
        
        let arraysNumber = addTenTimesRecordArrays.count
        //如果只有一個就直接加入
        if arraysNumber == 1 {
            addTenTimesRecordArrays.insert(contentsOf: [bestRecordList(second: "\(beginingSecond)", guess: "\(tenGuessCounts)", answer: "\(answer1)\(answer2)\(answer3)\(answer4)", date: "\(currectTime1)")], at: arraysNumber)
        }//兩個以上要比大小，超過十個刪除最後一個
        else if arraysNumber > 1 && arraysNumber < 21 {
            addTenTimesRecordArrays.insert(contentsOf: [bestRecordList(second: "\(beginingSecond)", guess: "\(tenGuessCounts)", answer: "\(answer1)\(answer2)\(answer3)\(answer4)", date: "\(currectTime1)")], at: arraysNumber)
            addTenTimesRecordArrays.sort { arrays1, arrays2 in
                return arrays1.guess.compare(arrays2.guess, options: .numeric) == .orderedDescending
            }
            addTenTimesRecordArrays.sort { array_1, array_2 in
                return array_1.guess.compare(array_2.guess, options: .numeric) == .orderedSame
            }
            
            //排序相反 不需要移動標題列
            /*let newCount = addTenTimesRecordArrays.count
            let newRow = newCount - 1
            let arrayTitle = addTenTimesRecordArrays[newRow]
            addTenTimesRecordArrays.insert(arrayTitle, at: 0)
            addTenTimesRecordArrays.remove(at: newCount)*/
        }
        //若超過前十名，比大小，贏的才納入，並刪除第11名
        else if arraysNumber == 21 {
            let row = arraysNumber - 1
            if tenGuessCounts > Int(addTenTimesRecordArrays[row].guess) ?? 0 {
                addTenTimesRecordArrays.insert(contentsOf: [bestRecordList(second: "\(beginingSecond)", guess: "\(tenGuessCounts)", answer: "\(answer1)\(answer2)\(answer3)\(answer4)", date: "\(currectTime1)")], at: arraysNumber)
                addTenTimesRecordArrays.sort { arrays1, arrays2 in
                    return arrays1.guess.compare(arrays2.guess, options: .numeric) == .orderedDescending
                }
                addTenTimesRecordArrays.sort { array_1, array_2 in
                    return array_1.guess.compare(array_2.guess, options: .numeric) == .orderedSame
                }
                
                //排序後 將標題列移回第一行
                /*let newCount = addTenTimesRecordArrays.count
                let newRow = newCount - 1
                let arrayTitle = addTenTimesRecordArrays[newRow]
                addTenTimesRecordArrays.insert(arrayTitle, at: 0)
                addTenTimesRecordArrays.remove(at: newCount)*/
                
                //將第21名刪掉
                addTenTimesRecordArrays.remove(at: 21)
                
            }
        }
    }
    
    //儲存排行榜資料
    func saveData() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(addTenTimesRecordArrays)  else { return }
        let userDefault = UserDefaults.standard
        userDefault.set(data, forKey: "bestRecordData_TenTimes")
    }
    
    //讀取儲存的資料
    func loadingSavedData() -> [bestRecordList]? {
        let userDefault = UserDefaults.standard
        guard let data = userDefault.data(forKey: "bestRecordData_TenTimes") else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([bestRecordList].self, from: data)
    }
    
    
    
    // MARK: - prepare
    // 傳資料到排行榜頁面
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? Best10TableViewController {
            controller.thisArrays = addTenTimesRecordArrays
        }
    }
    
}
