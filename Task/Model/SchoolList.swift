//
//  SchoolList.swift
//  Task
//
//  Created by Madhusudhan on 14/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

/**
 The purpose of the `SchoolList` is to save School information in parameters
 
 The `SchoolList` class is a subclass of the `NSObject`,
 */

class SchoolList: NSObject {
    
    /// String object that holds School ID
    var schoolID: String?
    
    /// String object that holds School Name
    var schoolName: String?
    
    /// String object that holds School Level
    var schoolLevel: String?
    
    /// String object that holds School Phone Number to contact
    var phone: String?
    
    /// String object that holds School Rank
    var rankMovement: String?
    
    /// String object that holds School Low Grade
    var lowGrade: String?
    
    /// String object that holds School High Grade
    var highGrade: String?
    
    /// String object that holds School Timings
    var privateHours: String?
    
    /// String object that holds School Address
    var address: String?
    
    /// String object that holds School Private or public
    var isPrivate: Bool?

    
    /** Getting data from dictionary and storing in each object with help Dictionary key's
     
     - Parameter dict: School Info With keys and values
     */
    init(dict: [String : Any]) {
        
        super.init()
        
        schoolID = String.checkNullValue((dict["schoolid"] ?? dict["schoolId"] as Any))
        schoolName = String.checkNullValue((dict["schoolName"] as Any))
        schoolLevel = String.checkNullValue((dict["schoolLevel"] as Any))
        phone = String.checkNullValue((dict["phone"] as Any))
        rankMovement = String.checkNullValue_NA((dict["rankMovement"] as Any))
        lowGrade = String.checkNullValue_NA((dict["lowGrade"] as Any))
        highGrade = String.checkNullValue_NA((dict["highGrade"] as Any))
        privateHours = String.checkNullValue_NA((dict["privateHours"] as Any))
        
        /* if address coming as Dictionary from api */
        if let dict1 = dict["address"] as? [String: Any] {
            address = String.checkNullValue(dict1["html"] as Any)
        }
        else {
            address = String.checkNullValue(dict["address"] as Any)
        }
        
        isPrivate = String.checkBoolNull((dict["isPrivate"] as Any))

    }
    
}



