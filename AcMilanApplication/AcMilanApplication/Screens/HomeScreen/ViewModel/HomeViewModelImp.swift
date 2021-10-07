//
//  HomeViewModelImp.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 02.08.2021..
//

import Foundation
import UIKit
import DropDown
import RxCocoa
import RxSwift
import Toast_Swift

class HomeViewModelImp: HomeViewModel {
    
    func configureButtons(dropDown: DropDown, dropDownButton: UIButton, seasonStatsButton: UIButton, buttonLabel: UILabel) {
        
        dropDown.dataSource = ["2016-2017", "2017-2018", "2018-2019", "2019-2020", "2020-2021"]
        dropDown.anchorView = dropDownButton
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else {return}
            dropDownButton.setTitle(item, for: .normal)
            buttonLabel.isHidden = true
            seasonStatsButton.setTitle("Season \(dropDownButton.titleLabel?.text ?? "")", for: .normal)
            seasonStatsButton.isEnabled = true
        }
    }
    
    func getFavoritePlayers(view: UIView, navigationController: UINavigationController){
        let favoritePlayers = UserDefaults.standard.value([PlayerDetails].self, forKey: "players")
        
        if favoritePlayers?.count == 0 {
            view.makeToast("First select favorite players.")
        }
        else {
            let svc = FavoritePlayersViewController(favoritePlayersViewModel: FavoritePlayersViewModelImp())
            navigationController.pushViewController(svc, animated: true)
        }
    }
}
