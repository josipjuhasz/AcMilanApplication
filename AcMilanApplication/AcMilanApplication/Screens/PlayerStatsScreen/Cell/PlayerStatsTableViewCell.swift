//
//  PlayerStatsTableViewCell.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 02.08.2021..
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class PlayerStatsTableViewCell: UITableViewCell {
    
    let cellView: UIView = {
        let cv = UIView()
        cv.layer.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1).cgColor
        cv.layer.cornerRadius = 20
        return cv
    }()
    
    let competitionImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }(
    )
    let competitionName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        return label
    }()
    
    let competitionGoals: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        return label
    }()
    
    let competitionAssists: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        return label
    }()
    
    let competitionAppearences: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        return label
    }()
    
    let competitionRating: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .white
        return label
    }()
    
    let competitionYellowCards: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        return label
    }()
    
    let competitionRedCards: UILabel = {
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
    
    func configureCell(data: PlayerStatistics){
        competitionImageView.kf.setImage(with: URL(string: data.league.logo ?? ""))
        competitionName.text = data.league.name
        competitionAppearences.text = "Appearences: \(data.games.appearences ?? 0)"
        competitionGoals.text = "Goals: \(data.goals.total ?? 0)"
        competitionAssists.text = "Assists: \(data.goals.assists ?? 0)"
        competitionYellowCards.text = "Yellow cards: \(data.cards.yellow ?? 0)"
        competitionRedCards.text = "Red cards: \(data.cards.red ?? 0)"
        competitionRating.text = "Rating: \(data.games.rating?.prefix(3) ?? "")"
    }
}

private extension PlayerStatsTableViewCell {
    func setupUI(){
        contentView.backgroundColor = UIColor(named: "backgroundColor")
        
        contentView.addSubview(cellView)
        cellView.addSubview(competitionName)
        cellView.addSubview(competitionGoals)
        cellView.addSubview(competitionAssists)
        cellView.addSubview(competitionRating)
        cellView.addSubview(competitionAppearences)
        cellView.addSubview(competitionYellowCards)
        cellView.addSubview(competitionRedCards)
        cellView.addSubview(competitionImageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        cellView.snp.makeConstraints{ (make) -> Void in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(200)
            make.bottom.equalToSuperview().priority(.low)
        }
        
        competitionImageView.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(140)
            make.width.equalTo(120)
        }
        
        competitionName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(competitionImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
        }
        
        competitionAppearences.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(13)
            make.leading.equalTo(competitionImageView.snp.trailing).offset(20)

        }
        
        competitionGoals.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(competitionAppearences.snp.bottom).offset(10)
            make.leading.equalTo(competitionImageView.snp.trailing).offset(20)
        }
        
        competitionAssists.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(competitionGoals.snp.bottom).offset(10)
            make.leading.equalTo(competitionImageView.snp.trailing).offset(20)
        }
        
        competitionYellowCards.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(competitionAssists.snp.bottom).offset(10)
            make.leading.equalTo(competitionImageView.snp.trailing).offset(20)
        }
        
        competitionRedCards.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(competitionYellowCards.snp.bottom).offset(10)
            make.leading.equalTo(competitionImageView.snp.trailing).offset(20)
        }
        
        competitionRating.snp.makeConstraints{ (make) -> Void in
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

