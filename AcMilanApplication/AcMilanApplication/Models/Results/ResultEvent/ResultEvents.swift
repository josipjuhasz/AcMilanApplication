//
//  ResultEvents.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 04.08.2021..
//

import Foundation

public struct ResultEvents: Codable {
    
    public let type: String
    public let time: ResultEventsTime
    public let team: ResultsHomeTeam
    public let player: PlayerInfo
    public let assist: PlayerInfo?
    public let detail: String?
    
}
