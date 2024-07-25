//
//  StoreLeaderboardModel.swift
//  little game
//
//  Created by Stephen on 2024/7/25.
//

import Foundation

final class StoreLeaderboardModel {
    /// 答對－計入排行榜
    func theBestRecord() {
        // let newRecord = ["\(beginingSecond)", "\(guessCounts)", "\(answer1)\(answer2)\(answer3)\(answer4)", "\(currectTime1)"]
        let arraysNumber = addBestRecordArrays.count
        // let row = arraysNumber - 1
        // 如果只有一個就直接加入
        if arraysNumber == 1 {
            addBestRecordArrays.insert(contentsOf: [bestRecordList(second: "\(beginingSecond)", guess: "\(g_guessCounts)", answer: "\(g_answer1)\(g_answer2)\(g_answer3)\(g_answer4)", date: "\(g_currectTime1)")], at: arraysNumber)
        } // 兩個以上要比大小，超過十個刪除最後一個
        else if arraysNumber > 1, arraysNumber < 21 {
            addBestRecordArrays.insert(contentsOf: [bestRecordList(second: "\(beginingSecond)", guess: "\(g_guessCounts)", answer: "\(g_answer1)\(g_answer2)\(g_answer3)\(g_answer4)", date: "\(g_currectTime1)")], at: arraysNumber)
            addBestRecordArrays.sort { arrays1, arrays2 in
                arrays1.second.compare(arrays2.second, options: .numeric) == .orderedAscending
            }
            addBestRecordArrays.sort { array_1, array_2 in
                array_1.second.compare(array_2.second, options: .numeric) == .orderedSame
            }

            // 排序後 將標題列移回第一行
            let newCount = addBestRecordArrays.count
            let newRow = newCount - 1
            let arrayTitle = addBestRecordArrays[newRow]
            addBestRecordArrays.insert(arrayTitle, at: 0)
            addBestRecordArrays.remove(at: newCount)
        }
        // 若超過前十名，比大小，贏的才納入，並刪除第11名
        else if arraysNumber == 21 {
            let row = arraysNumber - 1
            if beginingSecond < Int(addBestRecordArrays[row].second) ?? 0 {
                addBestRecordArrays.insert(contentsOf: [bestRecordList(second: "\(beginingSecond)", guess: "\(g_guessCounts)", answer: "\(g_answer1)\(g_answer2)\(g_answer3)\(g_answer4)", date: "\(g_currectTime1)")], at: arraysNumber)
                addBestRecordArrays.sort { arrays1, arrays2 in
                    arrays1.second.compare(arrays2.second, options: .numeric) == .orderedAscending
                }
                addBestRecordArrays.sort { array_1, array_2 in
                    array_1.second.compare(array_2.second, options: .numeric) == .orderedSame
                }

                // 排序後 將標題列移回第一行
                let newCount = addBestRecordArrays.count
                let newRow = newCount - 1
                let arrayTitle = addBestRecordArrays[newRow]
                addBestRecordArrays.insert(arrayTitle, at: 0)
                addBestRecordArrays.remove(at: newCount)
                // 將第11名刪掉
                addBestRecordArrays.remove(at: 21)
            }
        }
    }

    /// 增加排序參數
    func newArraysSetting() {
        addBestRecordArrays.sort { arrays1, arrays2 in
            arrays1.second.compare(arrays2.second, options: .numeric) == .orderedAscending
        }
        addBestRecordArrays.sort { array_1, array_2 in
            array_1.second.compare(array_2.second, options: .numeric) == .orderedSame
        }

        // 排序後 將標題列移回第一行
        let newCount = addBestRecordArrays.count
        let newRow = newCount - 1
        let arrayTitle = addBestRecordArrays[newRow]
        addBestRecordArrays.insert(arrayTitle, at: 0)
        addBestRecordArrays.remove(at: newCount)
    }

    /// 儲存排行榜資料
    func saveData() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(addBestRecordArrays) else { return }
        let userDefault = UserDefaults.standard
        userDefault.set(data, forKey: "bestRecordData")
    }

    /// 讀取儲存的資料
    func loadingSavedData() -> [bestRecordList]? {
        let userDefault = UserDefaults.standard
        guard let data = userDefault.data(forKey: "bestRecordData") else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([bestRecordList].self, from: data)
    }
}
