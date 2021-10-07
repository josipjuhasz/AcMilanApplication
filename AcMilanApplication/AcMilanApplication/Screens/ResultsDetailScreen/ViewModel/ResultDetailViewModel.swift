//
//  ResultDetailViewModel.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 04.08.2021..
//

import Foundation
import RxSwift
import RxCocoa

protocol ResultsDetailViewModel: AnyObject {
    
    var resultsDataRelay: BehaviorRelay<[ResultEvents]> {get}
    var loaderSubject: ReplaySubject<Bool> {get}
    var loadDataSubject: ReplaySubject<()> {get}
    
    func initializeViewModelObservables() -> [Disposable]
    func getTableCellValues(data: ResultEvents) -> [String]
}
