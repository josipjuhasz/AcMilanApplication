//
//  ResultsGamesFixture.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import Foundation

public struct ResultsGamesFixture: Codable {
    
    public let id: Int?
    public let referee: String?
    public let date: String?
    public let venue: ResultsFixtureVenue
    
}
