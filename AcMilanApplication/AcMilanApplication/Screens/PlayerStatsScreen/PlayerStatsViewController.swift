//
//  PlayerStatsViewController.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 02.08.2021..
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class PlayerStatsViewController: UIViewController {
    
    let playerStats: [PlayerStatistics]?
    
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
    
    init(playerStats: [PlayerStatistics]) {
        self.playerStats = playerStats
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

extension PlayerStatsViewController {
    
    func setupUI() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        view.addSubview(progressView)
        view.addSubview(tableView)
        view.bringSubviewToFront(progressView)
        
        setupTableView()
        setupConstraints()
    }
    
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCells() {
        tableView.register(PlayerStatsTableViewCell.self, forCellReuseIdentifier: "playerStatsTableViewCell")
    }
    
    func setupConstraints() {
        progressView.snp.makeConstraints{ (make) -> Void in
            make.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{ (make) -> Void in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension PlayerStatsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerStats?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cropCell = tableView.dequeueReusableCell(withIdentifier: "playerStatsTableViewCell", for: indexPath) as? PlayerStatsTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let result = playerStats?[indexPath.row]
        
        cropCell.configureCell(data: result!)
        return cropCell
    }
}
