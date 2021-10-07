//
//  HomeViewModel.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 02.08.2021..
//

import Foundation
import UIKit
import DropDown
import RxCocoa
import RxSwift

protocol HomeViewModel: AnyObject {
    
    func configureButtons(dropDown: DropDown, dropDownButton: UIButton, seasonStatsButton: UIButton, buttonLabel:UILabel)
    func getFavoritePlayers(view: UIView, navigationController: UINavigationController)
}
