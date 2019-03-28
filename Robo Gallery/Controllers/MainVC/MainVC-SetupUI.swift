//
//  MainVC-SetupUI.swift
//  Robo Gallery
//
//  Created by Sinjon Santos on 3/28/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import Material
import UIKit

extension MainViewController {
     func setupUI() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let gradientBackground = CAGradientLayer()
        gradientBackground.frame = self.view.bounds
        gradientBackground.colors = [UIColor(red:0.31, green:0.00, blue:0.74, alpha:1.0).cgColor, UIColor(red:0.16, green:0.67, blue:0.89, alpha:1.0).cgColor]
        gradientBackground.locations = [0.3, 1.0]
        view.layer.insertSublayer(gradientBackground, at: 0)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        titleLabel.center = CGPoint(x: view.frame.width/2, y: 85)
        titleLabel.text = "Robo Gallery"
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: "ProximaNova-Semibold", size: 34)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        robotTextField = TextField(frame: CGRect(x: 0, y: 0, width: 2*view.frame.width/5, height: 50))
        robotTextField.center = CGPoint(x: view.frame.width/2, y: 160)
        robotTextField.placeholder = "Robot name"
        robotTextField.placeholderNormalColor = .white
        robotTextField.textColor = .white
        robotTextField.placeholderVerticalOffset = 10
        robotTextField.placeholderActiveColor = .white
        robotTextField.dividerActiveColor = .white
        robotTextField.font = UIFont(name: "ProximaNova-Semibold", size: 22)
        robotTextField.autocorrectionType = UITextAutocorrectionType.no
        robotTextField.autocapitalizationType = UITextAutocapitalizationType.none
        robotTextField.delegate = self
        view.addSubview(robotTextField)
        
        setButton = Button(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        setButton.center = CGPoint(x: robotTextField.frame.minX - 50, y: robotTextField.center.y)
        setButton.layer.cornerRadius = 15
        setButton.backgroundColor = .gray
        setButton.setTitle("Set 1", for: .normal)
        setButton.setTitleColor(.white, for: .normal)
        setButton.titleLabel!.font = UIFont(name: "ProximaNova-Semibold", size: 18)
        setButton.addTarget(self, action: #selector(changeSet), for: .touchUpInside)
        view.addSubview(setButton)
        
        addButton = Button(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        addButton.center = CGPoint(x: robotTextField.frame.maxX + 30, y: robotTextField.center.y)
        addButton.setImage(UIImage(named: "add"), for: .normal)
        addButton.addTarget(self, action: #selector(add), for: .touchUpInside)
        view.addSubview(addButton)
        
        robotCollectionView = UICollectionView(frame: CGRect(x: 0, y: robotTextField.frame.maxY + 30, width: view.frame.width, height: view.frame.height-robotTextField.frame.maxY-30), collectionViewLayout: UICollectionViewFlowLayout())
        robotCollectionView.dataSource = self
        robotCollectionView.delegate = self
        robotCollectionView.register(MainVC_CollectionViewCell.self, forCellWithReuseIdentifier: "mainCell")
        robotCollectionView.backgroundColor = .white
        robotCollectionView.layer.cornerRadius = 30
        view.addSubview(robotCollectionView)
        
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(longPressGR:)))
        longPressGR.minimumPressDuration = 0.5
        longPressGR.delaysTouchesBegan = true
        robotCollectionView.addGestureRecognizer(longPressGR)
    }
}
