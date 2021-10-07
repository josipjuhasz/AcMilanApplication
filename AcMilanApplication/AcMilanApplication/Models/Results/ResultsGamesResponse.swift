//
//  ResultsGamesResponse.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import Foundation

public struct ResultsGamesResponse: Codable {
    public let fixture: ResultsGamesFixture
    public let league: ResultsGamesLeague
    public let teams: ResultsGamesTeams
    public let score: ResultsGamesScore
    public let events: [ResultEvents]?
}
