//
//  SeasonPlayers.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 30.07.2021..
//

import Foundation

public struct SeasonPlayer: Codable {
    
    public let playerId: Int
    public let playerName: String
    public let position: String
    public let age: Int
    public let birthDate: String
    public let number: Int?
    public let nationality: String
    public let height: String?
    public let weight: String?
}
