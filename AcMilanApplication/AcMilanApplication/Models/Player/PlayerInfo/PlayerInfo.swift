//
//  PlayerInfo.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 30.07.2021..
//

import Foundation

public struct PlayerInfo:Codable{
    public let id: Int?
    public let photo: String?
    public let name: String?
    public let firstname: String?
    public let lastname: String?
    public let age: Int?
    public let birth: PlayerInfoBirth?
    public let nationality: String?
    public let height: String?
    public let weight: String?
}
