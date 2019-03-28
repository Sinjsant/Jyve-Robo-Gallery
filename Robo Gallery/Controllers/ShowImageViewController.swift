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
       
        self.navigationItem.title = robotName
        
        
        robotPicture = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2))
        robotPicture.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        RobotHashAPIHelper.getRobotImage(name: robotName, set: robotSet) {img in
            self.robotPicture.image = img
        }
        robotPicture.contentMode = .scaleAspectFit
        view.addSubview(robotPicture)

        // Do any additional setup after loading the view.
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
