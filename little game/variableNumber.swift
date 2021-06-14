//
//  variableNumber.swift
//  little game
//
//  Created by 黃肇祺 on 2021/6/9.
//

import Foundation

//定義變數、常數
var keyNumber = 0 //判斷點擊的按鈕
var number1IsEmpty = true
var number2IsEmpty = true
var number3IsEmpty = true
var number4IsEmpty = true // 判斷是否已輸入數字
var answer1 = 0
var answer2 = 0
var answer3 = 0
var answer4 = 0 //答案數字
var guess1 = 0
var guess2 = 0
var guess3 = 0
var guess4 = 0 //紀錄猜的數字
var countA = 0
var countB = 0 //幾Ａ幾Ｂ數量

//紀錄過去猜的數字
var guessArrays1: [String] = ["", "", "", "", "", "", "", ]
var guessArrays2: [String] = ["", "", "", "", "", "", "", ]

var guessCounts = 0 //猜第幾次

var beginingSecond = 0
var timer: Timer? //計時前置準備

//時間字串
var currectTime1 = ""


struct bestRecordList: Codable {
    var second: String
    var guess: String
    var answer: String
    var date: String
}
