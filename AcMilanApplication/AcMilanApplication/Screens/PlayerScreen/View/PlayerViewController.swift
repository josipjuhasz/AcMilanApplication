//
//  PlayerViewController.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 01.08.2021..
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class PlayerViewController: UIViewController {
    
    var player: PlayerDetails
    let playerViewModel: PlayerViewModel
    let disposeBag = DisposeBag()
    
    let playerStatsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Player stats", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 0)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .white
        return view
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor(named: "backgroundColor")
        return tv
    }()
    
    let playerImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 20
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let transfersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.text = "Player transfers"
        return label
    }()
    
    let playerName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 0)
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let playerPosition: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let playerNationality: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let playerHeight: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let playerWeight: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let buttonFavorite: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        button.tintColor = .white
        return button
        
    }()
    
    init(player: PlayerDetails, playerViewModel: PlayerViewModel) {
        self.player = player
        self.playerViewModel = playerViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        playerViewModel.loadDataSubject.onNext(())
    }
}

extension PlayerViewController {
    
    func setupUI(){
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        view.addSubview(playerImageView)
        view.addSubview(playerName)
        view.addSubview(playerPosition)
        view.addSubview(playerNationality)
        view.addSubview(buttonFavorite)
        view.addSubview(progressView)
        view.addSubview(tableView)
        view.addSubview(transfersLabel)
        view.addSubview(playerStatsButton)
        view.addSubview(playerHeight)
        view.addSubview(playerWeight)
        view.bringSubviewToFront(progressView)
        
        setupConstraints()
        setupValues()
        setupTableView()
        setupPlayerViewModel()
        setupButtons()
    }
    
    func setupConstraints(){
        
        playerImageView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(260)
        }
        
        
        playerName.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playerImageView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalTo(playerStatsButton.snp.leading)
        }
        
        playerHeight.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playerName.snp.bottom).offset(20)
            make.leading.equalTo(playerPosition.snp.trailing).offset(20)
        }
        
        playerPosition.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playerName.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(25)
        }
        
        playerNationality.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playerPosition.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalTo(playerWeight.snp.leading).offset(-10)
        }
        
        playerWeight.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playerPosition.snp.bottom).offset(20)
            make.leading.equalTo(playerPosition.snp.trailing).offset(20)
        }
        
        transfersLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playerNationality.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        buttonFavorite.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playerStatsButton.snp.bottom).offset(35)
            make.trailing.equalToSuperview().offset(-50)
        }
        
        tableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(transfersLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        progressView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playerNationality.snp.bottom).offset(60)
            make.centerX.equalTo(tableView.snp.centerX)
        }
        
        playerStatsButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playerImageView.snp.bottom).offset(20)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }
    
    func setupValues(){
        
        playerImageView.kf.setImage(with: URL(string: player.player.photo ?? ""))
        playerName.text = player.player.name
        playerPosition.text = player.statistics[0].games.position
        playerNationality.text = player.player.nationality
        playerWeight.text = player.player.weight
        playerHeight.text = player.player.height
        
    }
    
    func setupPlayerViewModel(){
        disposeBag.insert(playerViewModel.initializeViewModelObservables())
        initializeLoaderObservable(subject: playerViewModel.loaderSubject).disposed(by: disposeBag)
        initializeTransfersDataObservable(subject: playerViewModel.transfersDataRelay).disposed(by: disposeBag)
    }
    
    func setupButtons(){
        
        
        buttonFavorite.isSelected = UserDefaults.standard.bool(forKey: "playerFavorite\(player.player.name ?? "")")
        
        setupButton(sender: buttonFavorite)
        
        playerStatsButton.rx.tap
            .bind(onNext: {
                let psvc = PlayerStatsViewController(playerStats: self.player.statistics)
                self.navigationController?.pushViewController(psvc, animated: true)
            })
            .disposed(by: disposeBag)
        
        buttonFavorite.rx.tap
            .bind{
                self.playerViewModel.buttonPressed(sender: self.buttonFavorite, player: self.player)
                self.setupButton(sender: self.buttonFavorite)
            }
            .disposed(by: disposeBag)
    }
}

extension PlayerViewController {
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCells() {
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "playerTableViewCell")
    }
}


extension PlayerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerViewModel.transfersDataRelay.value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cropCell = tableView.dequeueReusableCell(withIdentifier: "playerTableViewCell", for: indexPath) as? PlayerTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let transfer = playerViewModel.transfersDataRelay.value[indexPath.row]
        
        cropCell.configureCell(data: transfer)
        return cropCell
    }
}

extension PlayerViewController {
    func initializeLoaderObservable(subject: ReplaySubject<Bool>) -> Disposable {
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (status) in
                if status {
                    showLoader()
                } else {
                    hideLoader()
                }
            })
    }
    
    func initializeTransfersDataObservable(subject: BehaviorRelay<[TransfersValue]>) -> Disposable {
        return subject
            .observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background))
            .subscribe(onNext: { [unowned self] (items) in
                if !items.isEmpty {
                    tableView.reloadData()
                }
            })
    }
}

extension PlayerViewController: LoaderDelegate {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}

