//
//  Schools+CoreDataProperties.swift
//  
//
//  Created by Naresh Pendam on 18/11/19.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Schools {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schools> {
        return NSFetchRequest<Schools>(entityName: "Schools")
    }

    @NSManaged public var address: String?
    @NSManaged public var highGrade: String?
    @NSManaged public var isPrivate: Bool
    @NSManaged public var lowGrade: String?
    @NSManaged public var phone: String?
    @NSManaged public var privateHours: String?
    @NSManaged public var rankMovement: String?
    @NSManaged public var schoolid: String?
    @NSManaged public var schoolLevel: String?
    @NSManaged public var schoolName: String?

}
