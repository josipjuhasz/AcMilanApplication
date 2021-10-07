//
//  ClubInfoViewController.swift
//  AcMilanApplication
//
//  Created by Josip Juhasz on 29.07.2021..
//

import UIKit
import SnapKit

class ClubInfoViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let basicInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.text = "basicInfo".localized
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let extraInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Quicksand", size: 20)
        label.text = "extraInfo".localized
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let stadiumImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "sanSiro")
        return iv
    }()
    
    let stadiumNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "monteCarlo", size: 0)
        label.font = .italicSystemFont(ofSize: 13)
        label.text = "Stadio San Siro"
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let shortcutInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "chocolateCookies", size: 20)
        label.text = "shortcutInfo".localized
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension ClubInfoViewController {
    func setupUI(){
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = UIColor(named: "backgroundColor")
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(basicInfoLabel)
        contentView.addSubview(stadiumImageView)
        contentView.addSubview(extraInfoLabel)
        contentView.addSubview(stadiumNameLabel)
        contentView.addSubview(shortcutInfoLabel)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        
        scrollView.snp.makeConstraints{(make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints{ (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        basicInfoLabel.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        stadiumImageView.snp.makeConstraints{ (make) in
            make.top.equalTo(basicInfoLabel.snp.bottom).offset(10)
            make.height.equalTo(250)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        extraInfoLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(stadiumNameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        stadiumNameLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(stadiumImageView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            
        }
        
        shortcutInfoLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(extraInfoLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().priority(.low)
        }
    }
}

