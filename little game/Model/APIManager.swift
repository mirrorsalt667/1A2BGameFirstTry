//
//  APIManager.swift
//  little game
//
//  Created by Stephen on 2024/8/20.
//

import Alamofire

let localUrlHeader = "http://localhost:8000/"
let releaseUrlHeader = ""

typealias LeaderboardsCompletionHandler = (Result<[Leaderboards], Error>) -> Void
typealias LeaderboardCompletionHandler = (Result<Leaderboards, Error>) -> Void
typealias PlayersCompletionHandler = (Result<[Players], Error>) -> Void
typealias PlayerCompletionHandler = (Result<Players, Error>) -> Void

enum APISuffix: String {
    case leaderboards
    case leaderboard
    case players
    case player
    case generate = "player/generate/"
}

final class APIManager {
    func getLeaderboards(completion: @escaping LeaderboardsCompletionHandler) {
        #if DEBUG
        let url = localUrlHeader + APISuffix.leaderboards.rawValue
        #else
        let url = releaseUrlHeader + APISuffix.leaderboards.rawValue
        #endif
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode([Leaderboards].self, from: data)
                    completion(.success(result))
                } catch (let error) {
                    print(">>> JSON Decode ERROR")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getPlayers(completion: @escaping PlayersCompletionHandler) {
        #if DEBUG
        let url = localUrlHeader + APISuffix.players.rawValue
        #else
        let url = releaseUrlHeader + APISuffix.players.rawValue
        #endif
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode([Players].self, from: data)
                    completion(.success(result))
                } catch (let error) {
                    print(">>> JSON Decode ERROR")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func insertLeaderboard(_ put: Leaderboards, completion: @escaping LeaderboardCompletionHandler) {
        #if DEBUG
        let url = localUrlHeader + APISuffix.leaderboard.rawValue
        #else
        let url = releaseUrlHeader + APISuffix.leaderboard.rawValue
        #endif
        
        let parameters = put.toDictionary()
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let str = String(data: data, encoding: .utf8)!
                    print(">>> \(str)")
                    let result = try decoder.decode(Leaderboards.self, from: data)
                    completion(.success(result))
                } catch (let error) {
                    print(">>> JSON Decode ERROR")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func insertPlayer(_ put: Players, completion: @escaping PlayerCompletionHandler) {
        #if DEBUG
        let url = localUrlHeader + APISuffix.player.rawValue
        #else
        let url = releaseUrlHeader + APISuffix.player.rawValue
        #endif
        AF.request(url, method: .post, parameters: put).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Players.self, from: data)
                    completion(.success(result))
                } catch (let error) {
                    print(">>> JSON Decode ERROR")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func generateNewPlayer(completion: @escaping PlayerCompletionHandler) {
        #if DEBUG
        let url = localUrlHeader + APISuffix.generate.rawValue
        #else
        let url = releaseUrlHeader + APISuffix.generate.rawValue
        #endif
        AF.request(url, method: .get).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Players.self, from: data)
                    completion(.success(result))
                } catch (let error) {
                    print(">>> JSON Decode ERROR")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func patchPlayerName(_ id: Int, _ name: String, completion: @escaping PlayerCompletionHandler) {
        #if DEBUG
        let url = localUrlHeader + APISuffix.player.rawValue + "/\(id)"
        #else
        let url = releaseUrlHeader + APISuffix.player.rawValue + "/\(id)"
        #endif
        print(">>> API URL: \(url)")
        AF.request(url, method: .patch, parameters: ["player_name": name, "has_changed": true], encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Players.self, from: data)
                    completion(.success(result))
                } catch (let error) {
                    print(">>> JSON Decode ERROR")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
