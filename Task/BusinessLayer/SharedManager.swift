//
//  SharedManager.swift
//  Task
//
//  Created by Madhusudhan on 14/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

/**
 The purpose of the `SharedManager` is to use in this methods in multiple classe's without creating class instance in different classes
 
 The `SharedManager` class is a subclass of the `NSObject`,
 */
class SharedManager: NSObject {
    
    /// The Managed Object Context for the Fetch and save data in Database(Coredata) file.
    let managedObjectContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext

    /// single instance object for sharing the code without creating multiples instances
    @objc class var shared : SharedManager{
        
        struct singleton{
            static let instance = SharedManager()
        }
        return singleton.instance
    }
    
    
    /** Showing acivity indicator for Pagination
     
     - Parameters:
     - tableView: indicator for which tableView
     - indexPath: indexpath for Last Row identification
     */
    func showIndicatorForPaginationTableView(_ tableView: UITableView, forRowAt indexPath: IndexPath, perPage: Int) {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.row < perPage-2 {
            return
        }
        
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            tableView.tableFooterView = spinner
            tableView.tableFooterView?.isHidden = false
        }
        
    }
    
    /** Checking whether data is avaible or not in Array based that we have to show dataView or NoData available label
     
     - Parameters:
     - noDataLbl: Label
     - tableView: displaying data TableView
     /   - count: Api Response Data passing.
     */
    func showTableOrNoData(_ noDataLbl: UILabel, tableView: UITableView, count: Int) {
        
        if count == 0 {
            noDataLbl.isHidden = false
            tableView.isHidden = true
        }
        else {
            noDataLbl.isHidden = true
            tableView.isHidden = false
        }
        
        tableView.reloadData()
    }
    
    
    /** To make a call's for Displayed Phone Number to contact School's, etc...
     
     - Parameter number: PhoneNumber
     */
    func call(_ number : String) {
        
        var removeSpacesInNumber = number.trimmingCharacters(in: .whitespacesAndNewlines)
        
        removeSpacesInNumber = removeSpacesInNumber.replacingOccurrences(of: " ", with: "")
        
        // check whether device is supported to call or not
        if UIApplication.shared.canOpenURL(URL(string: "tel://\(removeSpacesInNumber)")!) {
            let url = URL(string: "tel://\(removeSpacesInNumber)")
            
            if #available(iOS 10, *) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url!)
            }
        }
        else {
            showAlert("Your device not supported to make a calls.")
        }
    }
    
    /** For saving school information in database file
    
     - Parameter schoolObj: school model object to store values
    */
    func insertSchoolinDataBase(_ schoolObj: SchoolList) {
        
        let entity = NSEntityDescription.entity(forEntityName: "Schools", in: managedObjectContext)
        let newUser = NSManagedObject(entity: entity!, insertInto: managedObjectContext)
        
        newUser.setValue(schoolObj.schoolID, forKey: "schoolid")
        newUser.setValue(schoolObj.schoolName, forKey: "schoolName")
        newUser.setValue(schoolObj.schoolLevel, forKey: "schoolLevel")
        newUser.setValue(schoolObj.phone, forKey: "phone")
        newUser.setValue(schoolObj.rankMovement, forKey: "rankMovement")
        newUser.setValue(schoolObj.lowGrade, forKey: "lowGrade")
        newUser.setValue(schoolObj.highGrade, forKey: "highGrade")
        newUser.setValue(schoolObj.privateHours, forKey: "privateHours")
        newUser.setValue(schoolObj.address, forKey: "address")
        newUser.setValue(schoolObj.isPrivate, forKey: "isPrivate")

        
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed saving")
        }
    }
    
    
    /** Fetching the data from database file with name of Schools Table
     
     - Returns: All table rows are storing in SchoolList Model Class
     */
    func getSchoolListFromDatabase() -> [SchoolList] {
        
        var tempArray = [SchoolList]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Schools")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedObjectContext.fetch(request)
            for data in result as! [NSManagedObject] {

                let dict = ["schoolid" : data.value(forKey: "schoolid") as! String,
                            "schoolName" : data.value(forKey: "schoolName") as! String,
                            "schoolLevel" : data.value(forKey: "schoolLevel") as! String,
                            "phone" : data.value(forKey: "phone") as! String,
                            "rankMovement" : data.value(forKey: "rankMovement") as! String,
                            "lowGrade" : data.value(forKey: "lowGrade") as! String,
                            "highGrade" : data.value(forKey: "highGrade") as! String,
                            "privateHours" : data.value(forKey: "privateHours") as! String,
                            "address" : data.value(forKey: "address") as! String,
                            "isPrivate" : data.value(forKey: "isPrivate") as! Bool] as [String : Any]
                
                print(dict)
                
                tempArray.append(SchoolList(dict: dict as [String : Any]))
                
            }
            
        } catch {
            
            print("Failed")
        }
        
        return tempArray
    }
    
}




