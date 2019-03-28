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
    
    var titleLabel: UILabel!
    
    var robotTextField: TextField!
    
    var robotCollectionView: UICollectionView!
    
    var addButton: Button!
    var setButton: Button!
   
    var selectedName = ""
    var selectedSet = 1

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // Auto hide virtual keyboard upon pressing return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    // Add robot button functionality
    @objc func add() {
        if robotTextField.text == "" {
            displayAlert(title: "Error", message: "Name must not be blank")
        } else {
            StorageSingleton.sharedInstance.pictures.insert(robotTextField.text!, at: 0)
            StorageSingleton.sharedInstance.save()
            robotCollectionView.reloadData()
        }
    }
    
    
    // Change set button action sheet
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
    
    
    // Long press gesture recognizer with action sheet for collection cells
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
    
    
    // Helper function to display alerts
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShowImage" {
            let destination = segue.destination as! ShowImageViewController
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
