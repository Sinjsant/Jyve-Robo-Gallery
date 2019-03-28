//
//  ShowImageViewController.swift
//  Robo Gallery
//
//  Created by Sinjon Santos on 3/27/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController {
    
    var robotName: String!
    var robotSet: Int!
    var robotPicture: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "ProximaNova-Semibold", size: 28)!, NSAttributedString.Key.foregroundColor: UIColor.black]
        
        setupUI()
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
