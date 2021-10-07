//
//  SeasonViewController.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 30.07.2021..
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class SeasonViewController: UIViewController {
    
    let seasonViewModel: SeasonViewModel
    var filteredData = BehaviorRelay<[PlayerDetails]>(value: [])
    let disposeBag = DisposeBag()
    
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
    
    let playersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Top Players", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 20)
        button.backgroundColor = UIColor(named: "buttonColor")
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search players..."
        return searchBar
    }()
    
    init(seasonViewModel: SeasonViewModel) {
        self.seasonViewModel = seasonViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        seasonViewModel.loadDataSubject.onNext(())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
}

private extension SeasonViewController {
    
    func setupUI(){
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        view.addSubview(progressView)
        view.addSubview(tableView)
        view.addSubview(searchBar)
        view.addSubview(playersButton)
        view.bringSubviewToFront(progressView)
        
        setupConstraints()
        setupSeasonViewModel()
        setupTableView()
        setupSearch()
        
        playersButton.rx.tap
            .bind(onNext: {
                let pvc = PopUpViewController(playerDetails: self.seasonViewModel.seasonDataRelay.value, popUpViewModel: PopUpViewModelImp())
                self.present(pvc, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    func setupSeasonViewModel(){
        disposeBag.insert(seasonViewModel.initializeViewModelObservables())
        initializeLoaderObservable(subject: seasonViewModel.loaderSubject).disposed(by: disposeBag)
        initializeResultsDataObservable(subject: seasonViewModel.seasonDataRelay).disposed(by: disposeBag)
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
        progressView.snp.makeConstraints{ (make) -> Void in
            make.center.equalTo(tableView)
        }
        
        searchBar.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(playersButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        playersButton.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
            make.height.equalTo(70)
        }
    }
}

extension SeasonViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cropCell = tableView.dequeueReusableCell(withIdentifier: "seasonTableViewCell", for: indexPath) as? SeasonTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let result = filteredData.value[indexPath.row]
        
        cropCell.configureCell(data: result)
        return cropCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let player = filteredData.value[indexPath.row]
        
        let playerVc = PlayerViewController(player: player, playerViewModel: PlayerViewModelImp(repository: RepositoryImpl(networkService: NetworkService()), id: player.player.id ?? 0))
        self.navigationController?.pushViewController(playerVc, animated: true)
    }
}

extension SeasonViewController {
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
    
    func initializeResultsDataObservable(subject: BehaviorRelay<[PlayerDetails]>) -> Disposable {
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

extension SeasonViewController: LoaderDelegate {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}

extension SeasonViewController: UISearchBarDelegate {
    
    func setupSearch(){
        searchBar.delegate = self
        filteredData = seasonViewModel.seasonDataRelay
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    
        filteredData = seasonViewModel.searchPlayers(data: seasonViewModel.seasonDataRelay, searchText: searchText)
        self.tableView.reloadData()
    }
}

