//
//  PlayerDetails.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 30.07.2021..
//

import Foundation

public struct PlayerDetails: Codable {

    public let player: PlayerInfo
    public let statistics: [PlayerStatistics]
    dynamic public var isSelected: Bool?

}
