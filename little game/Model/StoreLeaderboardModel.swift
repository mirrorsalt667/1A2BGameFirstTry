//
//  StoreLeaderboardModel.swift
//  little game
//
//  Created by Stephen on 2024/7/25.
//

import Foundation

enum GameMode {
    case timerMode
    case tenTimesMode
}

struct LeaderboardData: Codable {
    var second: String
    var guessingTimes: String
    var answer: String
    var date: String
}

final class StoreLeaderboardModel {
    private let timerModeTitle = LeaderboardData(second: "秒數", guessingTimes: "猜", answer: "答案", date: "日期")
    private let tenTimesModeTitle = LeaderboardData(second: "時間", guessingTimes: "剩餘", answer: "答案", date: "日期")
    private let timerModeKey = "bestRecordData"
    private let tenTimesModeKey = "tenTimesLeaderboardData"
    
    /// 答對－計入排行榜
    func addNewRecord(mode: GameMode,_ newRecord: LeaderboardData, records: [LeaderboardData]) -> [LeaderboardData] {
        var resultRecords = records
        let recordsLength = records.count
        // check if first index is title
        if recordsLength != 0 {
            if resultRecords[0].answer == timerModeTitle.answer {
                // remove title
                resultRecords.remove(at: 0)
            }
        }
        // 1 - 如果只有一個就直接加入
        if recordsLength == 0 {
            resultRecords.append(newRecord)
            // Add title
            if mode == .timerMode {
                resultRecords.insert(timerModeTitle, at: 0)
            } else {
                resultRecords.insert(tenTimesModeTitle, at: 0)
            }
            return resultRecords
            
        } // 2 - 2個以上要比大小，超過20刪除最後一個
        else if recordsLength > 0, recordsLength < 20 {
            resultRecords.append(newRecord)
            resultRecords.sort { arrays1, arrays2 in
                arrays1.second.compare(arrays2.second, options: .numeric) == .orderedAscending
            }
            resultRecords.sort { array_1, array_2 in
                array_1.second.compare(array_2.second, options: .numeric) == .orderedSame
            }

            // 排序後 add title
            if mode == .timerMode {
                resultRecords.insert(timerModeTitle, at: 0)
            } else {
                resultRecords.insert(tenTimesModeTitle, at: 0)
            }
            return resultRecords
        }
        // 3 - 若超過前20名，比大小，贏的才納入，並刪除第21名
        else if recordsLength == 20 {
            let last = recordsLength - 1
            if newRecord.second < resultRecords[last].second {
                resultRecords.append(newRecord)
                resultRecords.sort { arrays1, arrays2 in
                    arrays1.second.compare(arrays2.second, options: .numeric) == .orderedAscending
                }
                resultRecords.sort { array_1, array_2 in
                    array_1.second.compare(array_2.second, options: .numeric) == .orderedSame
                }
                // 將第21名刪掉
                resultRecords.remove(at: 21)
                // 排序後，add title
                if mode == .timerMode {
                    resultRecords.insert(timerModeTitle, at: 0)
                } else {
                    resultRecords.insert(tenTimesModeTitle, at: 0)
                }
                return resultRecords
            } else {
                // not append, just return
                return resultRecords
            }
        }
        return resultRecords
    }

    /// 增加排序參數
    func sortData(mode: GameMode, _ records: [LeaderboardData]) -> [LeaderboardData] {
        if mode == .timerMode {
            var records = records
            let recordsLength = records.count
            // check if first index is title
            if recordsLength != 0 {
                if records[0].answer == timerModeTitle.answer {
                    // remove title
                    records.remove(at: 0)
                }
            }
            records.sort { arrays1, arrays2 in
                arrays1.second.compare(arrays2.second, options: .numeric) == .orderedAscending
            }
            records.sort { array_1, array_2 in
                array_1.second.compare(array_2.second, options: .numeric) == .orderedSame
            }
            
            // 排序後 add title
            records.insert(timerModeTitle, at: 0)
            return records
        } else {
            var records = records
            let recordsLength = records.count
            // check if first index is title
            if recordsLength != 0 {
                if records[0].answer == tenTimesModeTitle.answer {
                    // remove title
                    records.remove(at: 0)
                }
            }
            records.sort { arrays1, arrays2 in
                arrays1.guessingTimes.compare(arrays2.guessingTimes, options: .numeric) == .orderedAscending
            }
            records.sort { array_1, array_2 in
                array_1.guessingTimes.compare(array_2.guessingTimes, options: .numeric) == .orderedSame
            }
            
            // 排序後 add title
            records.insert(tenTimesModeTitle, at: 0)
            return records
        }
    }

    /// 儲存排行榜資料
    func saveData(mode: GameMode, _ records: [LeaderboardData]) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(records) else { return }
        let userDefault = UserDefaults.standard
        if mode == .timerMode {
            userDefault.set(data, forKey: timerModeKey)
        } else {
            userDefault.set(data, forKey: tenTimesModeKey)
        }
    }

    /// 讀取儲存的資料
    func loadingSavedData(mode: GameMode) -> [LeaderboardData]? {
        let userDefault = UserDefaults.standard
        if mode == .timerMode {
            guard let data = userDefault.data(forKey: timerModeKey) else { return nil }
            let decoder = JSONDecoder()
            return try? decoder.decode([LeaderboardData].self, from: data)
        } else {
            guard let data = userDefault.data(forKey: tenTimesModeKey) else { return nil }
            let decoder = JSONDecoder()
            return try? decoder.decode([LeaderboardData].self, from: data)
        }
    }
}
