//
//  MainVC-CollectionViewCell.swift
//  Robo Gallery
//
//  Created by Sinjon Santos on 3/27/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import UIKit

class MainVC_CollectionViewCell: UICollectionViewCell {
    
    var RobotImage: UIImage!
    var RobotImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        RobotImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        RobotImageView.image = RobotImage
        RobotImageView.contentMode = .scaleAspectFit
        contentView.addSubview(RobotImageView)
    }
}
