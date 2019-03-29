//
//  Date+Helpers.swift
//  reach-ios
//
//  Created by Elie El Khoury on 3/2/19.
//  Copyright © 2019 Elie El Khoury. All rights reserved.
//

import UIKit

enum DateFormat : String {
    case DateFull = "dd MMMM YYYY"
    case DateJust = "dd/MM/YY"
    case DateHour = "dd/MM/YY - HH:mm"
    case HourMinute = "HH:mm"
    case YearMonthDay = "yyyy-MM-dd"
    case JSON = "yyyy-MM-dd HH:mm:ss"
    case Unix = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
}

extension Date {
    
    func add(minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: self)!
    }
    
    func add(hours: Int) -> Date {
        return Calendar.current.date(byAdding: .hour, value: hours, to: self)!
    }
    
    func roundUpHour() -> Date? {
        var components = NSCalendar.current.dateComponents([.minute], from: self)
        let minute = components.minute ?? 0
        components.minute = minute >= 0 ? 60 - minute : -minute
        
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    func dateFormatter(withFormat format:DateFormat) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = format.rawValue
        
        return dateFormatter
    }
    
    func toString(withFormat format:DateFormat) -> String {
        let dateFormatter = Date().dateFormatter(withFormat: format)
        return dateFormatter.string(from: self)
    }
    
    
    public static func relativeDateStringForDate(date: Date) -> String{
        let units: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear,.month,.year]
        // if `date` is before "now" (i.e. in the past) then the components will be positive
        let components = Calendar.current.dateComponents(units, from: date,  to: Date())
        
        let year = components.year
        let month = components.month
        let weekOfYear = components.weekOfYear
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        
        if year! > 1 {
            return "\(String(describing: year)) years"
        } else
            if year! > 0 {
                return "1 year"
            }
            else
                if month! > 1 {
                    return "\(Int(month!)) months"
                } else
                    if month! > 0 {
                        return "1 month"
                    }
                    else
                        if weekOfYear! > 1 {
                            return "\(Int(weekOfYear!)) weeks"
                        } else
                            if weekOfYear! > 0 {
                                return "1 week"
                            }
                            else
                                if day! > 1 {
                                    return "\(Int(day!)) days"
                                } else
                                    if day! > 0 {
                                        return "1 day"
                                    }
                                    else
                                        if hour! > 1 {
                                            return "\(Int(hour!))h"
                                        } else
                                            if hour! > 0 {
                                                return "1h"
                                            }
                                            else
                                                if minute! > 1 {
                                                    return "\(Int(minute!))m"
                                                } else
                                                    if minute! > 0 {
                                                        return "1m"
        }
        return "now"
        
        
    }
}
