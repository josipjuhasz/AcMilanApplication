//
//  PlayerViewModelImp.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 02.08.2021..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class PlayerViewModelImp: PlayerViewModel {
    
    var transfersDataRelay = BehaviorRelay<[TransfersValue]>.init(value: [])
    var favoritePlayersDataRelay: [PlayerDetails] = []
    var loadDataSubject = ReplaySubject<()>.create(bufferSize: 1)
    var loaderSubject = ReplaySubject<Bool>.create(bufferSize: 1)
    
    private let repository: Repository
    private let id: Int
    
    let dateFormatter = DateFormatter()
    let userDefaults = UserDefaults.standard
    
    init(repository: Repository, id: Int) {
        self.repository = repository
        self.id = id
    }
    
    func initializeViewModelObservables() -> [Disposable] {
        var disposables: [Disposable] = []
        disposables.append(initializeLoadResultsSubject(subject: loadDataSubject))
        return disposables
    }
    
    func buttonPressed(sender: UIButton, player: PlayerDetails){
        
        var user = UserDefaults.standard.value([PlayerDetails].self, forKey: "players") ?? []
        
        sender.isSelected = !sender.isSelected
    
        userDefaults.set(sender.isSelected, forKey: "playerFavorite\(player.player.name ?? "")")
        
        if sender.isSelected {
            
            user.append(player)
            userDefaults.set(encodable: user, forKey: "players")
        }
        else {
            if user.contains(where: {$0.player.name == player.player.name}){
                let playerIndex = user.firstIndex(where: {$0.player.name == player.player.name})
                user.remove(at: playerIndex ?? -1)
                userDefaults.set(encodable: user, forKey: "players")
            }
        }
    }
}

private extension PlayerViewModelImp {
    func initializeLoadResultsSubject(subject: ReplaySubject<()>) -> Disposable {
        return subject
            .flatMap{ [unowned self] (_) -> Observable<TransfersResponse> in
                self.loaderSubject.onNext(true)
                return self.repository.getTransfers(id: id)
            }
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { (transfersResonse) in
                if transfersResonse.response.count != 0 {
                    let sortedData = self.sortTransfers(data: transfersResonse.response[0].transfers)
                    self.transfersDataRelay.accept(sortedData)
                    self.loaderSubject.onNext(false)
                }
                self.loaderSubject.onNext(false)
            })
    }
}

private extension PlayerViewModelImp {
    
    func sortTransfers(data: [TransfersValue]) -> [TransfersValue]{
        
        var newData = data
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        newData.sort(by: {$0.date?.compare($1.date ?? "") == .orderedDescending})

        return newData
    }
    
}
