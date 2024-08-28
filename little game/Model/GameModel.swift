//
//  GameModel.swift
//  little game
//
//  Created by Stephen on 2024/7/25.
//

import Foundation

struct NumbersAndAB {
    let numbers: FourNumbersModel
    let abs: ABCounterModel
}

struct FourNumbersModel {
    var firstNumber: Int
    var secondNumber: Int
    var thirdNumber: Int
    var fourthNumber: Int
}

struct ABCounterModel {
    let aCounter: Int
    let bCounter: Int
}

struct InputProcessModel {
    var isFirstEmpty: Bool
    var isSecondEmpty: Bool
    var isThirdEmpty: Bool
    var isFourthEmpty: Bool
}

enum GameResult {
    case victory
    case defeat
    case continuing(_: ABCounterModel)
    case error(_: GameError)
}

enum GameError: Error {
    case gameNotStarting
}

final class GameModel {
    var theAnswer: FourNumbersModel?
    
    func fourNumberToOneString(_ input: FourNumbersModel) -> String {
        return "\(input.firstNumber)\(input.secondNumber)\(input.thirdNumber)\(input.fourthNumber)"
    }

    /// Create an answer
    func creatingAnswer() {
        let first = Int.random(in: 0 ... 9)
        var second = Int.random(in: 0 ... 9)
        while second == first {
            second = Int.random(in: 0 ... 9)
        }
        var third = Int.random(in: 0 ... 9)
        while third == second || third == first {
            third = Int.random(in: 0 ... 9)
        }
        var fourth = Int.random(in: 0 ... 9)
        while fourth == third || fourth == second || fourth == first {
            fourth = Int.random(in: 0 ... 9)
        }
        theAnswer = FourNumbersModel(firstNumber: first, secondNumber: second, thirdNumber: third, fourthNumber: fourth)
//        theAnswer = FourNumbersModel(firstNumber: 1, secondNumber: 2, thirdNumber: 3, fourthNumber: 5)
    }

    // Check if the response is right
    func checkResponse(_ response: FourNumbersModel) -> GameResult {
        guard let answer = theAnswer else { return .error(.gameNotStarting) }
        var aCounter = 0
        var bCounter = 0
        switch answer.firstNumber {
        case response.firstNumber: aCounter += 1
        case response.secondNumber, response.thirdNumber, response.fourthNumber: bCounter += 1
        default: break
        }
        switch answer.secondNumber {
        case response.secondNumber: aCounter += 1
        case response.firstNumber, response.thirdNumber, response.fourthNumber: bCounter += 1
        default: break
        }
        switch answer.thirdNumber {
        case response.thirdNumber: aCounter += 1
        case response.firstNumber, response.secondNumber, response.fourthNumber: bCounter += 1
        default: break
        }
        switch answer.fourthNumber {
        case response.fourthNumber: aCounter += 1
        case response.firstNumber, response.secondNumber, response.thirdNumber: bCounter += 1
        default: break
        }
        // 顯示猜測結果
        if aCounter == 4 { // 答對了
            return .victory
        } else {
            return .continuing(ABCounterModel(aCounter: aCounter, bCounter: bCounter))
        }
    }

    func getCurrentTime() -> String {
        let currectTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        let getDate = dateFormatter.string(from: currectTime)
        return getDate
    }
}
