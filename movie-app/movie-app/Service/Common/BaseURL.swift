//
//  BaseURL.swift
//  contacts-app
//
//  Created by IRFAN TRIHANDOKO on 15/06/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation

public struct BaseURL{
    static let ConfigBundle = [
        "base_url" :""
    ]
    
    public static func GetConfig() -> Dictionary<String, Any>? {
        var myDict: Dictionary<String, Any>?
        if let path = Bundle.main.path(forResource: "KMConfig", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            myDict = dict
            //            let d = NSDictionary(
        }
        
        if let url = Bundle.main.url(forResource: "KMConfig", withExtension: "plist")
        {
            let d = NSDictionary(contentsOf: url)
            debugPrint(url)
        } else {
            debugPrint("No url")
        }
        
        if let fileUrl = Bundle.main.url(forResource: "KMConfig", withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [[String: Any]] { // [String: Any] which ever it is
                debugPrint(result)
            }
        }
        return myDict
    }
    
    public static func GetUrl() -> String{
        if let config = GetConfig() {
            return config["base_url"] as! String
        }
        return ""
    }
    
    public static func GetImageUrl() -> String{
        if let config = GetConfig() {
            return config["image_url"] as! String
        }
        return ""
    }
}
