//
//  SeasonViewModelImp.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 30.07.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SeasonViewModelImp: SeasonViewModel {
    
    
    var seasonDataRelay = BehaviorRelay<[PlayerDetails]>.init(value: [])
    var loadDataSubject = ReplaySubject<()>.create(bufferSize: 1)
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    
    private let repository: Repository
    var season: String?
    
    init(repository: Repository, season: String) {
        self.repository = repository
        self.season = season
    }
    
    func initializeViewModelObservables() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeLoadSeasonSubject(subject: loadDataSubject))
        return disposables
    }
    
    func searchPlayers(data: BehaviorRelay<[PlayerDetails]>, searchText: String) -> BehaviorRelay<[PlayerDetails]> {
        
        var filteredData = BehaviorRelay<[PlayerDetails]>(value: [])
        
        if searchText == "" {
            filteredData = data
        }
        else {
            
            for player in data.value {
                
                if ((player.player.name?.lowercased().contains(searchText.lowercased()) == true)){
                    filteredData.accept(filteredData.value + [player])
                }
            }
        }
        return filteredData
    }
}

extension SeasonViewModelImp {
    func initializeLoadSeasonSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<PlayerResponse> in
                self.loaderSubject.onNext(true)
                return self.repository.getSeason(season: self.season ?? "")
            }
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (seasonResponse) in
                self.seasonDataRelay.accept(seasonResponse.response)
                self.loaderSubject.onNext(false)
            })
    }
}

