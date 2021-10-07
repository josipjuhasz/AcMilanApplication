//
//  StringExtension.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 03.08.2021..
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
