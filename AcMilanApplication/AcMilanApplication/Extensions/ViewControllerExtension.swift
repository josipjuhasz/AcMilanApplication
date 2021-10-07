//
//  ViewControllerExtension.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 03.08.2021..
//

import Foundation
import UIKit

extension UIViewController {
    func setupButton(sender: UIButton){
        sender.setImage(UIImage(systemName: "heart"), for: .normal)
        sender.setImage(UIImage(systemName: "heart.fill"), for: .selected)
    }
}
