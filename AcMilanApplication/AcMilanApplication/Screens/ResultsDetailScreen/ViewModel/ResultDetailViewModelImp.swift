//
//  ResultDetailViewModelImp.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 04.08.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ResultsDetailViewModelImpl: ResultsDetailViewModel {
    
    var resultsDataRelay = BehaviorRelay<[ResultEvents]>.init(value: [])
    var loadDataSubject = ReplaySubject<()>.create(bufferSize: 1)
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    
    private let repository: Repository
    let id: Int
    
    init(repository: Repository, id: Int) {
        self.repository = repository
        self.id = id
    }
    
    func initializeViewModelObservables() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeLoadResultsSubject(subject: loadDataSubject))
        return disposables
    }

    func getTableCellValues(data: ResultEvents) -> [String]{

        var values = [String]()
        var eventName = ""
        var eventPlayer = ""

        if data.detail == "Yellow Card" || data.detail == "Red Card" {
            eventPlayer = "\(data.player.name ?? "")"
            eventName = data.detail ?? ""
        }
        
        else if data.detail == "Penalty" {
            eventPlayer = "\(data.player.name ?? "")"
            eventName = "Goal - Penalty"
        }
        
        else if data.type == "subst" {
            eventPlayer = "IN - \(data.assist?.name ?? "") \nOUT - \(data.player.name ?? "")"
            eventName = String(data.detail?.prefix(12) ?? "")
        }
        
        else if data.type == "subst" {
            eventPlayer = "IN - \(data.assist?.name ?? "") \nOUT - \(data.player.name ?? "")"
            eventName = String(data.detail?.prefix(12) ?? "")
        }
        
        else if data.detail == "Missed Penalty" {
            eventName = data.detail ?? ""
            eventPlayer = "\(data.player.name ?? "")"
        }

        else {
            eventPlayer = "\(data.player.name ?? "") (\(data.assist?.name ?? ""))"
        }

        values.append(data.team.logo)
        values.append(String(data.time.elapsed))
        values.append(eventName)
        values.append(eventPlayer)

        return values
    }
}

private extension ResultsDetailViewModelImpl {
    func initializeLoadResultsSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<ResultsResponse> in
                self.loaderSubject.onNext(true)
                return self.repository.getResultsDetails(id: id)
            }
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (resultsResponse) in
                self.resultsDataRelay.accept(resultsResponse.response[0].events ?? [])
                self.loaderSubject.onNext(false)
            })
    }
}
