//
//  TransfersValue.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 01.08.2021..
//

import Foundation

public struct TransfersValue: Codable {
    public let date: String?
    public let type: String?
    public let teams: TransfersTeams
}
