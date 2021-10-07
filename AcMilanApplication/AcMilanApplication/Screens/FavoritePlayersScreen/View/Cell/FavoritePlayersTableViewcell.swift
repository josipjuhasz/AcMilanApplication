//
//  FavoritePlayersTableViewCell.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 06.08.2021..
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class FavoritePlayersTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let cv = UIView()
        cv.layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor
        cv.layer.cornerRadius = 20
        return cv
    }()
    
    let playerImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let playerName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension FavoritePlayersTableViewCell {
    func setupUI(){
        contentView.backgroundColor = UIColor(named: "backgroundColor")
        
        contentView.addSubview(cellView)
        cellView.addSubview(playerImageView)
        cellView.addSubview(playerName)

        setupConstraints()
    }
    
    func setupConstraints(){
        
        cellView.snp.makeConstraints{ (make) -> Void in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(200)
            make.bottom.equalToSuperview().priority(.low)
        }

        playerImageView.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.width.height.equalTo(130)
        }
        
        playerName.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(40)
            make.leading.equalTo(playerImageView.snp.trailing).offset(30)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

extension FavoritePlayersTableViewCell {
    func configureCell(data: PlayerDetails){

        playerImageView.kf.setImage(with: URL(string: data.player.photo ?? ""))
        playerName.text = data.player.name
    }
}
