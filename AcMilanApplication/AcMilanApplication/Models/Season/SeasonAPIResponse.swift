//
//  SeasonAPIResponse.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 30.07.2021..
//

import Foundation

public struct SeasonAPIReponse: Codable {
    
    public let results: Int
    public let players: [SeasonPlayer]
    
}
