//
//  ResultsResponse.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import Foundation

public struct ResultsResponse: Codable {
    public let get: String
    public let results: Int
    public let response: [ResultsGamesResponse]
}
