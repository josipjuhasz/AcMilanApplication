//
//  FavoritePlayersViewModel.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 06.08.2021..
//

import Foundation
import RxSwift
import RxCocoa

protocol FavoritePlayersViewModel: AnyObject {
    
    func checkFavoritePlayersCount(data: [PlayerDetails])
}
