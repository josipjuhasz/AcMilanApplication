//
//  ResultsViewModelImpl.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ResultsViewModelImpl: ResultsViewModel {
    
    var resultsDataRelay = BehaviorRelay<[ResultsGamesResponse]>.init(value: [])
    var loadDataSubject = ReplaySubject<()>.create(bufferSize: 1)
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func initializeViewModelObservables() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeLoadResultsSubject(subject: loadDataSubject))
        return disposables
    }
    
    func convertDate(date: String) -> String {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy HH:mm"
        
        guard let safeDate = dateFormatterGet.date(from: date) else {return "error"}
        
        return dateFormatterPrint.string(from: safeDate)
    }
    
    func setupTableViewExtraTime(data: ResultsGamesResponse) -> String{
        return ""
    }
}

private extension ResultsViewModelImpl {
    func initializeLoadResultsSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<ResultsResponse> in
                self.loaderSubject.onNext(true)
                return self.repository.getResults()
            }
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (resultsResponse) in
                self.resultsDataRelay.accept(resultsResponse.response)
                self.loaderSubject.onNext(false)
            })
    }
}
