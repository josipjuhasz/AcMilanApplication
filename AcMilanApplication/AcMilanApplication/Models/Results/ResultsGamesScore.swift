//
//  ResultsGamesScore.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import Foundation

public struct ResultsGamesScore: Codable {
    public let fulltime: ResultsScoreFullTime
    public let extratime: ResultsScoreExtraTime?
    public let penalty: ResultsScorePenalty?
}
