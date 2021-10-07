//
//  ViewController.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 28.07.2021..
//

import UIKit
import Kingfisher
import SnapKit
import RxCocoa
import RxSwift
import DropDown
import Toast_Swift


class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let dropDown = DropDown()
    var season: String = ""
    let homeViewModel: HomeViewModel?
    
    init(homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "milan")
        return logoImage
    }()
    
    let pumaImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "pumaLogo")
        return logoImage
    }()
    
    let emiratesImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "emiratesLogo")
        return logoImage
    }()
    
    let resultsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Last results", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 0)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let descriptionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Club info", for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 0)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let dropDownButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Season", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 0)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let seasonStatsButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 0)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        button.isEnabled = false
        return button
    }()
    
    let favoritePlayersButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Quicksand", size: 0)
        button.setTitle("Favorite Players", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = .red
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    let enableSeasonButtonLabel: UILabel = {
        let label = UILabel()
        label.text = "Select season to enable button."
        label.textColor = .white
        label.font = .italicSystemFont(ofSize: 12)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}

extension HomeViewController {
    
    func setupUI(){
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        view.addSubview(logoImage)
        view.addSubview(pumaImage)
        view.addSubview(emiratesImage)
        view.addSubview(resultsButton)
        view.addSubview(descriptionButton)
        view.addSubview(dropDownButton)
        view.addSubview(seasonStatsButton)
        view.addSubview(enableSeasonButtonLabel)
        view.addSubview(favoritePlayersButton)
        
        setupConstraints()
        setupButtons()
    }
    
    func setupConstraints(){
        
        logoImage.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(150)
            make.width.equalTo(200)
        }
        
        pumaImage.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview().offset(-70)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(75)
            make.width.equalTo(135)
        }
        
        emiratesImage.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview().offset(80)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(75)
            make.width.equalTo(100)
        }
        
        resultsButton.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(descriptionButton.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        descriptionButton.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImage.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        dropDownButton.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(resultsButton.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
        seasonStatsButton.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(dropDownButton.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.width.equalTo(200)
        }
        
        enableSeasonButtonLabel.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(seasonStatsButton.snp.bottom).offset(8)
        }
        
        favoritePlayersButton.snp.makeConstraints{ (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(enableSeasonButtonLabel.snp.bottom).offset(20)
            make.height.equalTo(40)
            make.width.equalTo(150)
        }
    }
    
    func setupButtons(){
        
        resultsButton.rx.tap
            .subscribe(onNext: {
                let rvc = ResultsViewController(resultsViewModel: ResultsViewModelImpl(repository: RepositoryImpl(networkService: NetworkService())))
                self.navigationController?.pushViewController(rvc, animated: true)
            })
            .disposed(by: disposeBag)
        
        descriptionButton.rx.tap
            .subscribe(onNext: {
                let civc = ClubInfoViewController()
                self.navigationController?.pushViewController(civc, animated: true)
            })
            .disposed(by: disposeBag)
        
        dropDownButton.rx.tap
            .subscribe(onNext: {                
                self.homeViewModel?.configureButtons(dropDown: self.dropDown, dropDownButton: self.dropDownButton, seasonStatsButton: self.seasonStatsButton, buttonLabel: self.enableSeasonButtonLabel)
            })
            .disposed(by: disposeBag)
        
        seasonStatsButton.rx.tap
            .subscribe(onNext: {
                let svc = SeasonViewController(seasonViewModel: SeasonViewModelImp(repository: RepositoryImpl(networkService: NetworkService()), season: "20\(self.dropDownButton.titleLabel?.text?.suffix(2) ?? "")"))
                self.navigationController?.pushViewController(svc, animated: true)
            })
            .disposed(by: disposeBag)
        
        favoritePlayersButton.rx.tap
            .subscribe(onNext: {
                self.homeViewModel?.getFavoritePlayers(view: self.view, navigationController: self.navigationController ?? UINavigationController())
            })
            .disposed(by: disposeBag)
    }
}
