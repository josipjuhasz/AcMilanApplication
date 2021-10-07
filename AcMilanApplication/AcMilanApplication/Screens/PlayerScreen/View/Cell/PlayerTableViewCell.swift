//
//  PlayerTableViewCell.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 02.08.2021..
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class PlayerTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let cv = UIView()
        cv.layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor
        cv.layer.cornerRadius = 20
        return cv
    }()
    
    let homeImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let arrowImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "arrow")
        return iv
    }()
    
    let awayImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let homeName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let awayName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let transferDate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        return label
    }()
    
    let transferType: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(data: TransfersValue){
        homeImageView.kf.setImage(with: URL(string: data.teams.out.logo ?? ""))
        awayImageView.kf.setImage(with: URL(string: data.teams.in.logo ?? ""))
        homeName.text = data.teams.out.name
        awayName.text = data.teams.in.name
        transferDate.text = data.date
        transferType.text = data.type
    }
}

private extension PlayerTableViewCell {
    func setupUI(){
        contentView.backgroundColor = UIColor(named: "backgroundColor")
        
        contentView.addSubview(cellView)
        cellView.addSubview(homeImageView)
        cellView.addSubview(awayImageView)
        cellView.addSubview(arrowImageView)
        cellView.addSubview(homeName)
        cellView.addSubview(awayName)
        cellView.addSubview(transferDate)
        cellView.addSubview(transferType)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        cellView.snp.makeConstraints{ (make) -> Void in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(170)
            make.bottom.equalToSuperview().priority(.low)
        }
        
        homeImageView.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(30)
            make.width.height.equalTo(50)
        }
        
        homeName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(homeImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(25)
        }
        
        awayImageView.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.width.height.equalTo(50)
        }
        
        awayName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(homeImageView.snp.bottom).offset(10)
            make.centerX.equalTo(awayImageView)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        arrowImageView.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        transferDate.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
        }
        
        transferType.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(arrowImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }
}
