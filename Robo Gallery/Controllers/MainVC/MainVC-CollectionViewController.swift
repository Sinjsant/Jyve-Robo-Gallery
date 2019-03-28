//
//  MainVC-CollectionViewController.swift
//  Robo Gallery
//
//  Created by Sinjon Santos on 3/27/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import Foundation
import UIKit


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StorageSingleton.sharedInstance.pictures.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = robotCollectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath as IndexPath) as! MainVC_CollectionViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let robotNames = StorageSingleton.sharedInstance.pictures
        RobotHashAPIHelper.getRobotImage(name: robotNames[indexPath.row], set: selectedSet) { img in
            cell.RobotImage = img
        }
        cell.awakeFromNib()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedName = StorageSingleton.sharedInstance.pictures[indexPath.row]
        performSegue(withIdentifier: "toShowImage", sender: self)
    }
    

    // Set cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: robotCollectionView.frame.width/5, height: robotCollectionView.frame.height/6)
    }
    
    
    // Add section margins
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let sectionInsets = UIEdgeInsets(top:0.0, left: 15.0, bottom: 0.0, right: 15.0)
        return sectionInsets
    }
}
