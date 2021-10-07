//
//  PopUpViewMocel.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 03.08.2021..
//

import Foundation
import RxSwift
import RxCocoa

protocol PopUpViewModel: AnyObject {
        
    func getPlayerStatistics(data: [PlayerDetails]) -> [String]
    
}
