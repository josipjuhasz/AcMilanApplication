//
//  ResultsViewModel.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import Foundation
import RxSwift
import RxCocoa

protocol ResultsViewModel: AnyObject {
    
    var resultsDataRelay: BehaviorRelay<[ResultsGamesResponse]> {get}
    var loaderSubject: ReplaySubject<Bool> {get}
    var loadDataSubject: ReplaySubject<()> {get}
    
    func initializeViewModelObservables() -> [Disposable]
    func setupTableViewExtraTime(data: ResultsGamesResponse) -> String
    func convertDate(date: String) -> String
}
