//
//  GameViewController.swift
//  little game
//
//  Created by 黃肇祺 on 2021/3/21.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var firstNumberLabel: UILabel!
    @IBOutlet weak var secondNumberLabel: UILabel!
    @IBOutlet weak var thirdNumberLabel: UILabel!
    @IBOutlet weak var fourthNumberLabel: UILabel!
    @IBOutlet weak var textLabel1: UILabel!
    @IBOutlet weak var textLabel2: UILabel!
    @IBOutlet weak var textLabel3: UILabel!
    @IBOutlet weak var textLabel4: UILabel!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var guessTimesLabel: UILabel!
    @IBOutlet weak var timeGoingLabel: UILabel!
    var firstNumber = 0
    var secondNumber = 0
    var thirdNumber = 0
    var fourthNumber = 0
    var answer = 0
    var Label1Text = false
    var Label2Text = false
    var Label3Text = false
    var Label4Text = false
    let numberOne = 1
    let numberTwo = 2
    let numberThree = 3
    let numberFour = 4
    let numberFive = 5
    let numberSix = 6
    let numberSeven = 7
    let numberEight = 8
    let numberNine = 9
    let numberZero = 0
    var howManyA = 0
    var howManyB = 0
    var guessTimes = 0
    var guess1Number = 0
    var guess2Number = 0
    var guess3Number = 0
    var guess4Number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func resetButton(_ sender: Any) {
        Label1Text = false
        Label2Text = false
        Label3Text = false
        Label4Text = false
        firstNumberLabel.text = "0"
        secondNumberLabel.text = "0"
        thirdNumberLabel.text = "0"
        fourthNumberLabel.text = "0"
        textLabel1.text = "0"
        textLabel2.text = "0"
        textLabel3.text = "0"
        textLabel4.text = "0"
        choosenNumber()
        guessTimes = 0
        guessTimesLabel.text = String("第0次")
        resultTextView.text = "開始！"
    }
    
    @IBAction func oneKeyButton(_ sender: Any) {
        keyInNumber1()
    }
    @IBAction func twoKeyButton(_ sender: Any) {
        keyInNumber2()
    }
    @IBAction func threeKeyButton(_ sender: Any) {
        keyInNumber3()
    }
    @IBAction func fourKeyButton(_ sender: Any) {
        keyInNumber4()
    }
    @IBAction func fiveKeyButton(_ sender: Any) {
        keyInNumber5()
    }
    @IBAction func sixKeyButton(_ sender: Any) {
        keyInNumber6()
    }
    @IBAction func sevenKeyButton(_ sender: Any) {
        keyInNumber7()
    }
    @IBAction func eightKeyButton(_ sender: Any) {
        keyInNumber8()
    }
    @IBAction func nineKeyButton(_ sender: Any) {
        keyInNumber9()
    }
    @IBAction func zeroKeyButton(_ sender: Any) {
        keyInNumber0()
    }
    @IBAction func delectButton(_ sender: Any) {
        if Label1Text == true , Label2Text == false , Label3Text == false , Label4Text == false {
            textLabel1.text = "0"
            Label1Text = false
        }
        if Label1Text == true , Label2Text == true , Label3Text == false , Label4Text == false {
            textLabel2.text = "0"
            Label2Text = false
        }
        if Label1Text == true , Label2Text == true , Label3Text == true , Label4Text == false {
            textLabel3.text = "0"
            Label3Text = false
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func keyInNumber1() {
        if Label1Text == false {
            textLabel1.text = String(numberOne)
            guess1Number = 1
            Label1Text = true
        } else if Label1Text == true , Label2Text == false {
            textLabel2.text = String(numberOne)
            guess2Number = 1
            Label2Text = true
        } else if Label2Text == true , Label3Text == false {
            textLabel3.text = String(numberOne)
            guess3Number = 1
            Label3Text = true
        } else {
            textLabel4.text = String(numberOne)
            guess4Number = 1
            Label4Text = true
            analysis()
        }
    }
    func keyInNumber2() {
        if Label1Text == false {
            textLabel1.text = String(numberTwo)
            guess1Number = 2
            Label1Text = true
        } else if Label1Text == true , Label2Text == false {
            textLabel2.text = String(numberTwo)
            guess2Number = 2
            Label2Text = true
        } else if Label2Text == true , Label3Text == false {
            textLabel3.text = String(numberTwo)
            guess3Number = 2
            Label3Text = true
        } else {
            textLabel4.text = String(numberTwo)
            guess4Number = 2
            Label4Text = true
            analysis()
        }
    }
    func keyInNumber3() {
        if Label1Text == false {
            textLabel1.text = String(numberThree)
            guess1Number = 3
            Label1Text = true
        } else if Label1Text == true , Label2Text == false {
            textLabel2.text = String(numberThree)
            guess2Number = 3
            Label2Text = true
        } else if Label2Text == true , Label3Text == false {
            textLabel3.text = String(numberThree)
            guess3Number = 3
            Label3Text = true
        } else {
            textLabel4.text = String(numberThree)
            guess4Number = 3
            Label4Text = true
            analysis()
        }
    }
    func keyInNumber4() {
        if Label1Text == false {
            textLabel1.text = String(numberFour)
            guess1Number = 4
            Label1Text = true
        } else if Label1Text == true , Label2Text == false {
            textLabel2.text = String(numberFour)
            guess2Number = 4
            Label2Text = true
        } else if Label2Text == true , Label3Text == false {
            textLabel3.text = String(numberFour)
            guess3Number = 4
            Label3Text = true
        } else {
            textLabel4.text = String(numberFour)
            guess4Number = 4
            Label4Text = true
            analysis()
        }
    }
    func keyInNumber5() {
        if Label1Text == false {
            textLabel1.text = String(numberFive)
            guess1Number = 5
            Label1Text = true
        } else if Label1Text == true , Label2Text == false {
            textLabel2.text = String(numberFive)
            guess2Number = 5
            Label2Text = true
        } else if Label2Text == true , Label3Text == false {
            textLabel3.text = String(numberFive)
            guess3Number = 5
            Label3Text = true
        } else {
            textLabel4.text = String(numberFive)
            guess4Number = 5
            Label4Text = true
            analysis()
        }
    }
    func keyInNumber6() {
        if Label1Text == false {
            textLabel1.text = String(numberSix)
            guess1Number = 6
            Label1Text = true
        } else if Label1Text == true , Label2Text == false {
            textLabel2.text = String(numberSix)
            guess2Number = 6
            Label2Text = true
        } else if Label2Text == true , Label3Text == false {
            textLabel3.text = String(numberSix)
            guess3Number = 6
            Label3Text = true
        } else {
            textLabel4.text = String(numberSix)
            guess4Number = 6
            Label4Text = true
            analysis()
        }
    }
    func keyInNumber7() {
        if Label1Text == false {
            textLabel1.text = String(numberSeven)
            guess1Number = 7
            Label1Text = true
        } else if Label1Text == true , Label2Text == false {
            textLabel2.text = String(numberSeven)
            guess2Number = 7
            Label2Text = true
        } else if Label2Text == true , Label3Text == false {
            textLabel3.text = String(numberSeven)
            guess3Number = 7
            Label3Text = true
        } else {
            textLabel4.text = String(numberSeven)
            guess4Number = 7
            Label4Text = true
            analysis()
        }
    }
    func keyInNumber8() {
        if Label1Text == false {
            textLabel1.text = String(numberEight)
            guess1Number = 8
            Label1Text = true
        } else if Label1Text == true , Label2Text == false {
            textLabel2.text = String(numberEight)
            guess2Number = 8
            Label2Text = true
        } else if Label2Text == true , Label3Text == false {
            textLabel3.text = String(numberEight)
            guess3Number = 8
            Label3Text = true
        } else {
            textLabel4.text = String(numberEight)
            guess4Number = 8
            Label4Text = true
            analysis()
        }
    }
    func keyInNumber9() {
        if Label1Text == false {
            textLabel1.text = String(numberNine)
            guess1Number = 9
            Label1Text = true
        } else if Label1Text == true , Label2Text == false {
            textLabel2.text = String(numberNine)
            guess2Number = 9
            Label2Text = true
        } else if Label2Text == true , Label3Text == false {
            textLabel3.text = String(numberNine)
            guess3Number = 9
            Label3Text = true
        } else {
            textLabel4.text = String(numberNine)
            guess4Number = 9
            Label4Text = true
            analysis()
        }
    }
    func keyInNumber0() {
        if Label1Text == false {
            textLabel1.text = String(numberZero)
            guess1Number = 0
            Label1Text = true
        } else if Label1Text == true , Label2Text == false {
            textLabel2.text = String(numberZero)
            guess2Number = 0
            Label2Text = true
        } else if Label2Text == true , Label3Text == false {
            textLabel3.text = String(numberZero)
            guess3Number = 0
            Label3Text = true
        } else {
            textLabel4.text = String(numberZero)
            guess4Number = 0
            Label4Text = true
            analysis()
        }
    }
    
    func choosenNumber() {
        firstNumber = Int.random(in: 0...9)
        secondNumber = Int.random(in: 0...9)
        thirdNumber = Int.random(in: 0...9)
        fourthNumber = Int.random(in: 0...9)
        while secondNumber == firstNumber {
            secondNumber = Int.random(in: 0...9)
        }
        while thirdNumber == secondNumber || thirdNumber == firstNumber {
            thirdNumber = Int.random(in: 0...9)
        }
        while fourthNumber == thirdNumber || fourthNumber == secondNumber || fourthNumber == firstNumber {
            fourthNumber = Int.random(in: 0...9)
        }
    }
    func analysis() {
        if textLabel1.text == String(firstNumber) {
            howManyA += 1
        }
        if textLabel2.text == String(secondNumber) {
            howManyA += 1
        }
        if textLabel3.text == String(thirdNumber) {
            howManyA += 1
        }
        if textLabel4.text == String(fourthNumber) {
            howManyA += 1
        }
        if textLabel1.text != String(firstNumber) {
            if textLabel1.text == String(secondNumber) || textLabel1.text == String(thirdNumber) || textLabel1.text == String(fourthNumber) {
                howManyB += 1
                if textLabel1.text == textLabel2.text || textLabel1.text == textLabel3.text || textLabel1.text == textLabel4.text {
                    howManyB -= 1
                }
            }
        }
        if textLabel2.text != String(secondNumber) {
            if textLabel2.text == String(firstNumber) || textLabel2.text == String(thirdNumber) || textLabel2.text == String(fourthNumber) {
                howManyB += 1
                if textLabel2.text == textLabel1.text || textLabel2.text == textLabel3.text || textLabel2.text == textLabel4.text{
                    howManyB -= 1
                }
            }
        }
        if textLabel3.text != String(thirdNumber) {
            if textLabel3.text == String(firstNumber) || textLabel3.text == String(secondNumber) || textLabel3.text == String(fourthNumber) {
                howManyB += 1
                if textLabel3.text == textLabel2.text || textLabel3.text == textLabel1.text || textLabel3.text == textLabel4.text {
                    howManyB -= 1
                }
            }
        }
        if textLabel4.text != String(fourthNumber) {
            if textLabel4.text == String(firstNumber) || textLabel4.text == String(secondNumber) || textLabel4.text == String(thirdNumber) {
                howManyB += 1
                if textLabel4.text == textLabel3.text || textLabel4.text == textLabel2.text || textLabel4.text == textLabel1.text {
                    howManyB -= 1
                }
            }
        }
        resultTextView.text = String("\(guess1Number) \(guess2Number) \(guess3Number) \(guess4Number)的結果是\(howManyA)A\(howManyB)B。")
        guessTimes += 1
        guessTimesLabel.text = String("猜第\(guessTimes)次")
        if howManyA == 4 {
            endAction()
        } else {
            howManyA = 0
            howManyB = 0
            Label1Text = false
            Label2Text = false
            Label3Text = false
            Label4Text = false
        }
    }
    func endAction() {
        resultTextView.text = "恭喜"
        firstNumberLabel.text = String(firstNumber)
        secondNumberLabel.text = String(secondNumber)
        thirdNumberLabel.text = String(thirdNumber)
        fourthNumberLabel.text = String(fourthNumber)
    }
}
