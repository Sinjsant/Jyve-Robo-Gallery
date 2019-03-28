//
//  StorageSingleton.swift
//  Robo Gallery
//
//  Created by Sinjon Santos on 3/27/19.
//  Copyright © 2019 Sinjon Santos. All rights reserved.
//

import Foundation

class StorageSingleton {
    static var sharedInstance: StorageSingleton = StorageSingleton()
    var pictures:[String]
    private init() {
        if let storedPics = UserDefaults.standard.array(forKey: "pictures") as? [String] {
            pictures = storedPics
        } else {
            pictures = []
        }
    }
    
    func save() {
        //Saving code
        UserDefaults.standard.set(pictures, forKey: "pictures")
    }
}
