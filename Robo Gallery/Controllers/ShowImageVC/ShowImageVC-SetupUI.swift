//
//  ShowImageVC-SetupUI.swift
//  Robo Gallery
//
//  Created by Sinjon Santos on 3/28/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import UIKit

extension ShowImageViewController {
    func setupUI() {
        self.navigationItem.title = robotName
        
        robotPicture = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2))
        robotPicture.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        RobotHashAPIHelper.getRobotImage(name: robotName, set: robotSet) {img in
            self.robotPicture.image = img
        }
        robotPicture.contentMode = .scaleAspectFit
        view.addSubview(robotPicture)
    }
}
