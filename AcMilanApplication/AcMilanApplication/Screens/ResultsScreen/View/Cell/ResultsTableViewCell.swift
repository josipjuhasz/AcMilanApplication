//
//  ResultsTableViewCell.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class ResultsTableViewCell: UITableViewCell {
    
    let resultViewModel = ResultsViewModelImpl(repository: RepositoryImpl(networkService: NetworkService()))
    
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
    
    let homeName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let awayImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let awayName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let datePlayed: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        return label
    }()
    
    let finalResult: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    let matchType: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        return label
    }()
    
    let refereeName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let stadiumName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let extraTimeResult: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .white
        return label
    }()
    
    let penaltyResult: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
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
    
    func configureCell(data: ResultsGamesResponse){
        homeImageView.kf.setImage(with: URL(string: data.teams.home.logo))
        homeName.text = data.teams.home.name
        awayImageView.kf.setImage(with: URL(string: data.teams.away.logo))
        awayName.text = data.teams.away.name
        datePlayed.text = resultViewModel.convertDate(date: data.fixture.date ?? "")
        finalResult.text = "\(data.score.fulltime.home ?? -1) - \(data.score.fulltime.away ?? -1)"
        stadiumName.text = "\(data.fixture.venue.name ?? "N/A"), \(data.fixture.venue.city ?? "N/A")"
        refereeName.text = "Referee: \(data.fixture.referee ?? "N/A")"
        matchType.text = data.league.name
        checkForExtraTime(data: data)
    }
}

private extension ResultsTableViewCell {
    func setupUI(){
        contentView.backgroundColor = UIColor(named: "backgroundColor")
        
        contentView.addSubview(cellView)
        cellView.addSubview(homeImageView)
        cellView.addSubview(awayImageView)
        cellView.addSubview(homeName)
        cellView.addSubview(awayName)
        cellView.addSubview(refereeName)
        cellView.addSubview(finalResult)
        cellView.addSubview(datePlayed)
        cellView.addSubview(stadiumName)
        cellView.addSubview(extraTimeResult)
        cellView.addSubview(penaltyResult)
        cellView.addSubview(matchType)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        cellView.snp.makeConstraints{ (make) -> Void in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(290)
            make.bottom.equalToSuperview().priority(.low)
        }
        
        homeImageView.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(40)
            make.width.height.equalTo(70)
        }
        
        homeName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(homeImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalTo(finalResult.snp.leading)
        }
        
        awayImageView.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-35)
            make.width.height.equalTo(70)
        }

        awayName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(awayImageView.snp.bottom).offset(20)
            make.leading.equalTo(penaltyResult.snp.trailing).offset(80)
            make.trailing.equalToSuperview().offset(-10)
        }

        datePlayed.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }

        finalResult.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
        }
        
        extraTimeResult.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(finalResult.snp.bottom).offset(5)
        }
        
        penaltyResult.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(extraTimeResult.snp.bottom).offset(5)
        }

        stadiumName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(homeName.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        refereeName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(stadiumName.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        matchType.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(refereeName.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}

private extension ResultsTableViewCell {
    
    func checkForExtraTime(data: ResultsGamesResponse){
        
        if data.score.extratime?.home != nil {
            extraTimeResult.text = "E.T.: \(data.score.extratime?.home ?? -1) - \(data.score.extratime?.away ?? -1)"
        }
        
        if data.score.penalty?.home != nil {
            penaltyResult.text = "Penalties: \(data.score.penalty?.home ?? -1) - \(data.score.penalty?.away ?? -1)"
        }
    }
}
