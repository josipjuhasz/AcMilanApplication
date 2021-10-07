//
//  ResultsDetailViewController.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 04.08.2021..
//

import UIKit
import SnapKit
import Kingfisher
import RxCocoa
import RxSwift

class ResultsDetailViewController: UIViewController {
    
    let resultDetailViewModel: ResultsDetailViewModel
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
    
    init(resultDetailViewModel: ResultsDetailViewModel) {
        self.resultDetailViewModel = resultDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        resultDetailViewModel.loadDataSubject.onNext(())
    }
}

private extension ResultsDetailViewController {
    
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
        disposeBag.insert(resultDetailViewModel.initializeViewModelObservables())
        initializeLoaderObservable(subject: resultDetailViewModel.loaderSubject).disposed(by: disposeBag)
        initializeResultsDataObservable(subject: resultDetailViewModel.resultsDataRelay).disposed(by: disposeBag)
    }
    
    func setupTableView() {
        registerCells()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCells() {
        tableView.register(ResultsDetailTableViewCell.self, forCellReuseIdentifier: "resultsDetailTableViewCell")
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

extension ResultsDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultDetailViewModel.resultsDataRelay.value.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cropCell = tableView.dequeueReusableCell(withIdentifier: "resultsDetailTableViewCell", for: indexPath) as? ResultsDetailTableViewCell else {
            print("failed to dequeue the wanted cell")
            return UITableViewCell()
        }
        
        let result = resultDetailViewModel.resultsDataRelay.value[indexPath.row]
        
        let tableViewCellValues = resultDetailViewModel.getTableCellValues(data: result)
        
        cropCell.configureCell(data: tableViewCellValues)
        return cropCell
    }
}

extension ResultsDetailViewController {
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
    
    func initializeResultsDataObservable(subject: BehaviorRelay<[ResultEvents]>) -> Disposable {
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

extension ResultsDetailViewController: LoaderDelegate {
    
    func showLoader() {
        progressView.isHidden = false
        progressView.startAnimating()
    }
    
    func hideLoader() {
        progressView.isHidden = true
        progressView.stopAnimating()
    }
}


