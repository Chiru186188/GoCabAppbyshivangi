//
//  Config.swift
//  Shared
//
//  Created by Manly Man on 11/22/19.
//  Copyright © 2019 Innomalist. All rights reserved.
//Hiii

import Foundation

class Config {
    
    // static var Backend: String = "https://api.go-cabs.com/"
    //   static var Backend: String = "https://api-stage.go-cabs.com/"
    static var Backend: String = "https://api-dev.go-cabs.com/"

    //static var Backend: String
    
    

    static var Version: String {
        get {
            return self.Info["CFBundleVersion"] as! String
        }
    }
    
    static var Info: [String:Any] {
        get {
            let path = Bundle.main.path(forResource: "Info", ofType: "plist")!
            return NSDictionary(contentsOfFile: path) as! [String: Any]
        }
    }
}
