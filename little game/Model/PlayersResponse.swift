//
//  PlayersResponse.swift
//  little game
//
//  Created by Stephen on 2024/8/19.
//

struct Players: Codable {
    let id: Int
    let player_id_str: String
    let player_name: String
    let create_time: String
}
