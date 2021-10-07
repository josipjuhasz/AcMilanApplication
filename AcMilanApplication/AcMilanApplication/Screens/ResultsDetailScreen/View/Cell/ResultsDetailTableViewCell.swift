//
//  ResultsDetailTableViewCell.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 04.08.2021..
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class ResultsDetailTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let cv = UIView()
        cv.layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor
        cv.layer.cornerRadius = 20
        return cv
    }()
    
    let clubImageView: UIImageView = {
        let clubImageView = UIImageView()
        return clubImageView
        
    }()
    
    let eventName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    let eventMinute: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    let eventPlayer: UILabel = {
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
    
    func configureCell(data: [String]){
        eventName.text = data[2]
        eventMinute.text = "\(data[1])'"
        clubImageView.kf.setImage(with: URL(string: data[0]))
        eventPlayer.text = data[3]
    }
}

private extension ResultsDetailTableViewCell {
    func setupUI(){
        contentView.backgroundColor = UIColor(named: "backgroundColor")
        
        contentView.addSubview(cellView)
        cellView.addSubview(eventName)
        cellView.addSubview(eventPlayer)
        cellView.addSubview(eventMinute)
        cellView.addSubview(clubImageView)
    
        setupConstraints()
    }
    
    func setupConstraints() {
        
        cellView.snp.makeConstraints{ (make) -> Void in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(200)
            make.bottom.equalToSuperview().priority(.low)
        }
        
        eventName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(eventMinute.snp.bottom).offset(20)
            make.leading.equalTo(clubImageView.snp.trailing).offset(30)
        }
        
        clubImageView.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(120)
        }
        
        eventMinute.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(30)
            make.leading.equalTo(clubImageView.snp.trailing).offset(30)
        }
        
        eventPlayer.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(eventName.snp.bottom).offset(20)
            make.leading.equalTo(clubImageView.snp.trailing).offset(30)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}


