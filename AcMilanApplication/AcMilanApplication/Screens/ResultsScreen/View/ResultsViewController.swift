//
//  ResultsViewController.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class ResultsViewController: UIViewController {
    
    let resultsViewModel: ResultsViewModel
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
    
    init(resultsViewModel: ResultsViewModel) {
        self.resultsViewModel = resultsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        resultsViewModel.loadDataSubject.onNext(())
    }
}

private extension ResultsViewController {
    
    func setupUI() {
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        view.addSubview(progressView)
        view.addSubview(tableView)
        view.bringSubviewToFront(progressView)
        
        setupConstraints()
        setupTableView()
        setupResultViewModel()
    }
    
    func setupResultViewModel(){
        disposeBag.insert(resultsViewModel.initializeViewModelObservables())
        initializeLoaderObservable(subject: resultsViewModel.loaderSubject).disposed(by: disposeBag)
        initializeResultsDataObservable(subject: resultsViewModel.resultsDataRelay).disposed(by: disposeBag)
    }
    
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCells() {
        tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: "resultsTableViewCell")
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

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsViewModel.resultsDataRelay.value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cropCell = tableView.dequeueReusableCell(withIdentifier: "resultsTableViewCell", for: indexPath) as? ResultsTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let result = resultsViewModel.resultsDataRelay.value[indexPath.row]
        
        cropCell.configureCell(data: result)
        return cropCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventId = resultsViewModel.resultsDataRelay.value[indexPath.row].fixture.id ?? 0
        
        let rdvc = ResultsDetailViewController(resultDetailViewModel: ResultsDetailViewModelImpl(repository: RepositoryImpl(networkService: NetworkService()), id: eventId))
        self.navigationController?.pushViewController(rdvc, animated: true)
    }
}

extension ResultsViewController {
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
    
    func initializeResultsDataObservable(subject: BehaviorRelay<[ResultsGamesResponse]>) -> Disposable {
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

extension ResultsViewController: LoaderDelegate {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}


