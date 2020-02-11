//
//  DateHelper.swift
//  movie-app
//
//  Created by IRFAN TRIHANDOKO on 03/12/19.
//  Copyright © 2019 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation

public class DateHelper {
    
    public static func dateParseToStringUTC(_ date: Date, newFormat: String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = newFormat
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    public static func dateParseToStringUTC(_ date: String, oldFormat: String, newFormat: String)-> String {
        let dateFormatter = DateFormatter()
        var newDateString = ""
        dateFormatter.dateFormat = oldFormat
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        if let mydate = dateFormatter.date(from: date){
            dateFormatter.dateFormat = newFormat
            newDateString = dateFormatter.string(from: mydate)
        }
        return newDateString
    }
    
}
