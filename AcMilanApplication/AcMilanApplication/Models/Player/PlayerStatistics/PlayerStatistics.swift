//
//  PlayerStatistics.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 30.07.2021..
//

import Foundation

public struct PlayerStatistics: Codable{
    
    public let team: PlayerStatisticsTeam
    public let games: PlayerStatisticsGames
    public let goals: PlayerStatisticsGoals
    public let cards: PlayerStatisticsCards
    public let league: PlayerStatisticsLeague
}
