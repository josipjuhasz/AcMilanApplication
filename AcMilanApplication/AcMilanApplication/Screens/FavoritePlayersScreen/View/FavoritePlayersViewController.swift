//
//  FavoritePlayersViewController.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 06.08.2021..
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class FavoritePlayersViewController: UIViewController {
    
    var favoritePlayers = UserDefaults.standard.value([PlayerDetails].self, forKey: "players") ?? []
    let favoritePlayersViewModel: FavoritePlayersViewModel

    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor(named: "backgroundColor")
        return tv
    }()
    
    init(favoritePlayersViewModel: FavoritePlayersViewModel) {
        self.favoritePlayersViewModel = favoritePlayersViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favoritePlayers = UserDefaults.standard.value([PlayerDetails].self, forKey: "players") ?? []
        favoritePlayersViewModel.checkFavoritePlayersCount(data: favoritePlayers)
        self.tableView.reloadData()
    }
}

private extension FavoritePlayersViewController {
    
    func setupUI(){
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        view.addSubview(tableView)
        
        setupConstraints()
        setupTableView()
    }
    
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func registerCells() {
        tableView.register(SeasonTableViewCell.self, forCellReuseIdentifier: "seasonTableViewCell")
    }
    
    func setupConstraints() {
        
        tableView.snp.makeConstraints{ (make) -> Void in
            make.edges.equalToSuperview()
        }
    }
}

extension FavoritePlayersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritePlayers.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cropCell = tableView.dequeueReusableCell(withIdentifier: "seasonTableViewCell", for: indexPath) as? SeasonTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let result = favoritePlayers[indexPath.row]
        
        cropCell.configureCell(data: result)
        return cropCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let player = favoritePlayers[indexPath.row]
        
        let playerVc = PlayerViewController(player: player, playerViewModel: PlayerViewModelImp(repository: RepositoryImpl(networkService: NetworkService()), id: player.player.id ?? 0))
        self.navigationController?.pushViewController(playerVc, animated: true)
    }
}

