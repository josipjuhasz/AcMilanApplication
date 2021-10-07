//
//  PopUpViewController.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 03.08.2021..
//

import UIKit
import RxCocoa
import RxSwift

class PopUpViewController: UIViewController {
    
    let players: [PlayerDetails]
    let popUpViewModel: PopUpViewModel
    let disposeBag = DisposeBag()
    
    let playersView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    let dismissButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    let topScorer: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 0.145, green: 0.4, blue: 0.51, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    let topAssists: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 0.145, green: 0.4, blue: 0.51, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    let mostAppearances: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 0.145, green: 0.4, blue: 0.51, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    let highestRating: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = UIColor(red: 0.145, green: 0.4, blue: 0.51, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    let topScorerImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let topAssistsImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let mostAppearancesImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let highestRatingImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    init(playerDetails: [PlayerDetails], popUpViewModel: PopUpViewModel) {
        self.players = playerDetails
        self.popUpViewModel = popUpViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupUI()
    }
}

extension PopUpViewController {
    
    func setupUI(){
    
        view.addSubview(playersView)
        playersView.addSubview(topScorer)
        playersView.addSubview(topAssists)
        playersView.addSubview(mostAppearances)
        playersView.addSubview(highestRating)
        playersView.addSubview(topScorerImageView)
        playersView.addSubview(topAssistsImageView)
        playersView.addSubview(highestRatingImageView)
        playersView.addSubview(mostAppearancesImageView)
        playersView.addSubview(dismissButton)
        
        setupConstraints()
        setupValues()
        
        dismissButton.rx.tap
            .bind(onNext: {
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
    }
    
    func setupConstraints(){
        
        playersView.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.6)
            
        }
        
        mostAppearancesImageView.snp.makeConstraints{ (make) -> Void in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.height.width.equalTo(90)
        }
        
        topScorerImageView.snp.makeConstraints{ (make) -> Void in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(mostAppearancesImageView.snp.bottom).offset(20)
            make.height.width.equalTo(90)
        }
        
        topAssistsImageView.snp.makeConstraints{ (make) -> Void in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(topScorerImageView.snp.bottom).offset(20)
            make.height.width.equalTo(90)
        }
        
        highestRatingImageView.snp.makeConstraints{ (make) -> Void in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(topAssistsImageView.snp.bottom).offset(20)
            make.height.width.equalTo(90)
        }
        
        mostAppearances.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(mostAppearancesImageView)
            make.leading.equalTo(mostAppearancesImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        topScorer.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(topScorerImageView)
            make.leading.equalTo(topScorerImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        topAssists.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(topAssistsImageView)
            make.leading.equalTo(topAssistsImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        highestRating.snp.makeConstraints{ (make) -> Void in
            make.centerY.equalTo(highestRatingImageView)
            make.leading.equalTo(highestRatingImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    
        dismissButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
        }
    }
    
    func setupValues(){
        let topPlayers = popUpViewModel.getPlayerStatistics(data: players)
        
        topScorer.text = topPlayers[0]
        topScorerImageView.kf.setImage(with: URL(string: topPlayers[1]))
        topAssists.text = topPlayers[2]
        topAssistsImageView.kf.setImage(with: URL(string: topPlayers[3]))
        mostAppearances.text = topPlayers[4]
        mostAppearancesImageView.kf.setImage(with: URL(string: topPlayers[5]))
        highestRating.text = topPlayers[6]
        highestRatingImageView.kf.setImage(with: URL(string: topPlayers[7]))
    }
    
}
