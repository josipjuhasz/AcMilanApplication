//
//  PlayerViewModel.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 02.08.2021..
//

import Foundation
import RxSwift
import RxCocoa

protocol PlayerViewModel: AnyObject {
    
    var transfersDataRelay: BehaviorRelay<[TransfersValue]> {get}
    var loaderSubject: ReplaySubject<Bool> {get}
    var loadDataSubject: ReplaySubject<()> {get}
    
    func initializeViewModelObservables() -> [Disposable]
    func buttonPressed(sender: UIButton, player: PlayerDetails)    
}
