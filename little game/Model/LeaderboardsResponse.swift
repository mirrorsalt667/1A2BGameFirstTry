//
//  LeaderboardsResponse.swift
//  little game
//
//  Created by Stephen on 2024/8/19.
//

struct Leaderboards: Codable {
    let id: Int
    let mode: Int
    let seconds: Int
    let times: String
    let answer: String
    let timestamp: String
    let player_id: Int
    let player_id_str: String
    let player_name: String
}