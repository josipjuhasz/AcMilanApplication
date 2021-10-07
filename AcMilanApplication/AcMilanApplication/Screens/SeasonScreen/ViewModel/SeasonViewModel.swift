//
//  SeasonViewModel.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 30.07.2021..
//

import Foundation
import RxSwift
import RxCocoa

protocol SeasonViewModel: AnyObject {
    
    var seasonDataRelay: BehaviorRelay<[PlayerDetails]> {get}
    var loaderSubject: ReplaySubject<Bool> {get}
    var loadDataSubject: ReplaySubject<()> {get}
    
    func initializeViewModelObservables() -> [Disposable]
    func searchPlayers(data: BehaviorRelay<[PlayerDetails]>, searchText: String) -> BehaviorRelay<[PlayerDetails]>
}
