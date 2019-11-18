//
//  NSObject+Foundation.swift
//  Task
//
//  Created by Madhusudhan on 12/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    
    /// For Checking Null Type For each parameter From Api or Database
    ///
    /// - Parameter inputValue: Actual value
    /// - Returns: empty value if null is coming api or database
    static func checkNullValue(_ inputValue: Any) -> String {
        
        var valueString : Any = inputValue
        
        if (valueString as AnyObject).isEqual(NSNull()) {
            valueString = ""
        }
        else {
            if let someObj = valueString as? NSNumber {
                valueString = String(format: "%.2f", someObj.floatValue)
            }
            if let someObj = valueString as? Double {
                valueString = String(format: "%f", someObj)
            }
        }
        return (valueString as! String).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// For Checking Null Type For each parameter From Api or Database
    ///
    /// - Parameter inputValue: Actual value
    /// - Returns: empty value if NotAvailable is coming api or database - If value is available then returing actual value
    static func checkNullValue_NA(_ inputValue: Any) -> String {
        
        var valueString : Any = inputValue
        
        if (valueString as AnyObject).isEqual(NSNull()) {
            valueString = "NA"
        }
        else {
            
            if let someObj = valueString as? NSNumber {
                valueString = String(format: "%.0f", someObj.floatValue)
            }
        }
        
        return (valueString as! String).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// For Checking Null Type For each parameter From Api or Database
    ///
    /// - Parameter inputValue: Actual value
    /// - Returns: empty value if empty is coming api or database - If value is available then returing actual value
    static func checkNSNumberNull(_ inputValue: Any) -> String {
        
        var valueString = inputValue
        
        if (valueString as AnyObject).isEqual(NSNull()) {
            valueString = ""
        }
        else {
            valueString = String(valueString as! Int)
            
        }
        
        return valueString as! String
    }
    
    /// For Checking Null Type For each parameter From Api or Database
    ///
    /// - Parameter inputValue: Actual value
    /// - Returns: false saving defaulty if NULL is coming api or database - If value is available then returing actual value
    static func checkBoolNull(_ value : Any) -> Bool {
        
        var newBoolValue : Any = value
        
        if (newBoolValue as AnyObject).isEqual(NSNull()) {
            newBoolValue = false
        }
        else {

        }
        return newBoolValue as! Bool
    }
    
    /// For Checking Null Type For each parameter From Api or Database
    ///
    /// - Parameter inputValue: Actual value
    /// - Returns: empty Array if Null is coming api or database - If value is available then returing actual value
    static func checkArray(_ value : Any) -> NSArray {
        
        var newValue : Any = value
        
        if (newValue as AnyObject).isEqual(NSNull()) {
            newValue = NSArray()
        }
        else {
        
        }
        return newValue as! NSArray
    }
    
    /// For Checking Null Type For each parameter From Api or Database
    ///
    /// - Parameter inputValue: Actual value
    /// - Returns: empty Dictionary if Null is coming api or database - If value is avaiable then returing actual value
    static func checkDictionary(_ value : Any) -> NSDictionary {
        
        var newValue : Any = value
        
        if (newValue as AnyObject).isEqual(NSNull()) {
            newValue = NSDictionary()
        }
        else {

        }
        return newValue as! NSDictionary
    }
    
}
