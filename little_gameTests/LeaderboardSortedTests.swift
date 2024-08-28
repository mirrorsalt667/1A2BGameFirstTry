//
//  LeaderboardSortedTests.swift
//  little game
//
//  Created by Stephen on 2024/8/28.
//

import XCTest
import UIKit
@testable import little_game

final class LeaderboardSortedTests: XCTestCase {
    
    var viewController: LeaderboardViewController?

    /// Put setup code here. This method is called before the invocation of each test method in the class.
    override func setUpWithError() throws {
        let storyboard = UIStoryboard.init(name: "Leaderboard", bundle: nil)
        viewController = storyboard.instantiateViewController(identifier: "LeaderboardViewController") as? LeaderboardViewController
        viewController?.type = .timer
    }

    /// Put teardown code here. This method is called after the invocation of each test method in the class.
    override func tearDownWithError() throws {
    }

    func testLeaderboardSortInTimerType() throws {
        let type: LeaderboardTypes = .timer
        let leaderboards: [Leaderboards] = [
            Leaderboards(id: 1, mode: 0, seconds: 88, times: "15", answer: "1234", timestamp: "2020/06/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 2, mode: 0, seconds: 120, times: "3", answer: "1234", timestamp: "2021/09/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 3, mode: 0, seconds: 88, times: "9", answer: "1234", timestamp: "2022/06/23 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 4, mode: 0, seconds: 153, times: "27", answer: "1234", timestamp: "2024/06/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 5, mode: 0, seconds: 98, times: "15", answer: "1234", timestamp: "2023/07/28 03:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
        ]
        let correctResult: [Leaderboards] = [
            Leaderboards(id: 3, mode: 0, seconds: 88, times: "9", answer: "1234", timestamp: "2022/06/23 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 1, mode: 0, seconds: 88, times: "15", answer: "1234", timestamp: "2020/06/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 5, mode: 0, seconds: 98, times: "15", answer: "1234", timestamp: "2023/07/28 03:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 2, mode: 0, seconds: 120, times: "3", answer: "1234", timestamp: "2021/09/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 4, mode: 0, seconds: 153, times: "27", answer: "1234", timestamp: "2024/06/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
        ]
        let testResult = viewController!.sortLeaderboard(type, dataSource: leaderboards)
        
        for i in 0 ..< testResult.count {
            XCTAssertEqual(testResult[i].id, correctResult[i].id, "Went wrong in index \(i)")
        }
    }
    
    func testLeaderboardSortInCountdownType() throws {
        let type: LeaderboardTypes = .countdown
        let leaderboards: [Leaderboards] = [
            Leaderboards(id: 1, mode: 0, seconds: 88, times: "8", answer: "1234", timestamp: "2020/06/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 2, mode: 0, seconds: 120, times: "2", answer: "1234", timestamp: "2021/09/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 3, mode: 0, seconds: 88, times: "6", answer: "1234", timestamp: "2022/06/23 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 4, mode: 0, seconds: 153, times: "2", answer: "1234", timestamp: "2024/06/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 5, mode: 0, seconds: 98, times: "0", answer: "1234", timestamp: "2023/07/28 03:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
        ]
        let correctResult: [Leaderboards] = [
            Leaderboards(id: 1, mode: 0, seconds: 88, times: "8", answer: "1234", timestamp: "2020/06/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 3, mode: 0, seconds: 88, times: "6", answer: "1234", timestamp: "2022/06/23 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 2, mode: 0, seconds: 120, times: "2", answer: "1234", timestamp: "2021/09/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 4, mode: 0, seconds: 153, times: "2", answer: "1234", timestamp: "2024/06/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 5, mode: 0, seconds: 98, times: "0", answer: "1234", timestamp: "2023/07/28 03:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
        ]
        let testResult = viewController!.sortLeaderboard(type, dataSource: leaderboards)
        
        for i in 0 ..< testResult.count {
            XCTAssertEqual(testResult[i].id, correctResult[i].id, "Went wrong in index \(i)")
        }
    }
    
    func testLeaderboardSortInLuckyType() throws {
        let type: LeaderboardTypes = .lucky
        let leaderboards: [Leaderboards] = [
            Leaderboards(id: 1, mode: 0, seconds: 88, times: "1", answer: "1234", timestamp: "2021/06/28 01:29:31", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 2, mode: 0, seconds: 120, times: "1", answer: "1234", timestamp: "2021/09/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 3, mode: 0, seconds: 88, times: "1", answer: "1234", timestamp: "2021/09/28 01:30:32", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 4, mode: 0, seconds: 153, times: "1", answer: "1234", timestamp: "2021/06/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 5, mode: 0, seconds: 98, times: "1", answer: "1234", timestamp: "2021/07/28 03:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
        ]
        let correctResult: [Leaderboards] = [
            Leaderboards(id: 3, mode: 0, seconds: 88, times: "1", answer: "1234", timestamp: "2021/09/28 01:30:32", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 2, mode: 0, seconds: 120, times: "1", answer: "1234", timestamp: "2021/09/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 5, mode: 0, seconds: 98, times: "1", answer: "1234", timestamp: "2021/07/28 03:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 1, mode: 0, seconds: 88, times: "1", answer: "1234", timestamp: "2021/06/28 01:29:31", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
            Leaderboards(id: 4, mode: 0, seconds: 153, times: "1", answer: "1234", timestamp: "2021/06/28 01:29:30", player_id: 1, player_id_str: "ABCDEFG", player_name: "A"),
        ]
        let testResult = viewController!.sortLeaderboard(type, dataSource: leaderboards)
        
        for i in 0 ..< testResult.count {
            XCTAssertEqual(testResult[i].id, correctResult[i].id, "Went wrong in index \(i)")
        }
    }
}
