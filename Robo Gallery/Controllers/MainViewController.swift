//
//  MainViewController.swift
//  Robo Gallery
//
//  Created by Sinjon Santos on 3/27/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import UIKit
import Material

class MainViewController: UIViewController, UITextFieldDelegate {
    
    var robotTextField: TextField!
    var robotCollectionView: UICollectionView!
    var addButton: Button!
    var setButton: Button!
   
    var selectedName = ""
    var selectedSet = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        robotTextField = TextField(frame: CGRect(x: 0, y: 0, width: 2*view.frame.width/5, height: 50))
        robotTextField.center = CGPoint(x: view.frame.width/2, y: 120)
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
        
        

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @objc func add() {
        if robotTextField.text == "" {
            displayAlert(title: "Error", message: "Name must not be blank")
        } else {
            StorageSingleton.sharedInstance.pictures.insert(robotTextField.text!, at: 0)
            StorageSingleton.sharedInstance.save()
            robotCollectionView.reloadData()
        }
    }
    
    @objc func changeSet() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let changeSet1 = UIAlertAction(title: "Set 1", style: .default) { (action) in
            self.setButton.setTitle("Set 1", for: .normal)
            self.selectedSet = 1
            self.robotCollectionView.reloadData()
        }
        let changeSet2 = UIAlertAction(title: "Set 2", style: .default) { (action) in
            self.setButton.setTitle("Set 2", for: .normal)
            self.selectedSet = 2
            self.robotCollectionView.reloadData()

        }
        let changeSet3 = UIAlertAction(title: "Set 3", style: .default) { (action) in
            self.setButton.setTitle("Set 3", for: .normal)
            self.selectedSet = 3
            self.robotCollectionView.reloadData()

        }
        sheet.addAction(cancelAction)
        sheet.addAction(changeSet1)
        sheet.addAction(changeSet2)
        sheet.addAction(changeSet3)
        present(sheet, animated: true, completion: nil)
    }
    
    
    @objc func handleLongPress(longPressGR: UILongPressGestureRecognizer) {
        if longPressGR.state != .ended {
            return
        }
        
        let point = longPressGR.location(in: robotCollectionView)
        let indexPath = robotCollectionView.indexPathForItem(at: point)
        
        if let indexPath = indexPath {
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
                StorageSingleton.sharedInstance.pictures.remove(at: indexPath.row)
                StorageSingleton.sharedInstance.save()
                self.robotCollectionView.reloadData()
            }
            sheet.addAction(cancelAction)
            sheet.addAction(deleteAction)
            
            present(sheet, animated: true, completion: nil)
        } else {
            print("Could not find index path")
        }
    }
    
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toShowImage" {
            var destination = segue.destination as! ShowImageViewController
            destination.robotName = selectedName
            destination.robotSet = selectedSet
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
