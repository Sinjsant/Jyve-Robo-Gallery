//
//  RoboHashAPIHelper.swift
//  Robo Gallery
//
//  Created by Sinjon Santos on 3/27/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import Foundation
import UIKit


class RobotHashAPIHelper {
    
    static func getRobotImage(name: String, set: Int, completion: @escaping (UIImage) -> ()) {
        let imageURL = "https://robohash.org/\(name)?set=set\(set)"
        if let url = URL(string: imageURL) {
            do {
                let data = try Data(contentsOf: url)
                completion(UIImage(data: data)!)
            } catch let err {
                print("Error : \(err.localizedDescription)")
            }
        }
        
    }
    
}
