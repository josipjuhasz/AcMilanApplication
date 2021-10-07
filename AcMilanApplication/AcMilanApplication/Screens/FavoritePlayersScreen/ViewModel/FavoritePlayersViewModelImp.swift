//
//  FavoritePlayersViewModelImp.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 06.08.2021..
//


import Foundation
import UIKit
import RxSwift
import RxCocoa

class FavoritePlayersViewModelImp: FavoritePlayersViewModel {
    
    func checkFavoritePlayersCount(data: [PlayerDetails]) {
        
        if data.count == 0 {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
               appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
               (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
            }
        }
    }
}
