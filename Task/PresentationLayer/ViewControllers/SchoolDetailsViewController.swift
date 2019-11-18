//
//  SchoolDetailsViewController.swift
//  Task
//
//  Created by Madhusudhan on 14/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//

import UIKit

/**
 The purpose of the `SchoolDetailsViewController` is to show the Selcted School information in detail way
 
 There's a matching scene in the *Main.storyboard* file, and in that scene there is a `UIScrollView` with `UILabels` design. Go to Interface Builder for details.
 
 The `SchoolDetailsViewController` class is a subclass of the `UIViewController`.
 */
class SchoolDetailsViewController: UIViewController {

    /// object that holds the selected school object from the previous screen
    var schoolObj: SchoolList!
    
    /// Label to show the School Name
    @IBOutlet weak var schoolNameLbl: UILabel!
    
    /// Label to show the School Level
    @IBOutlet weak var schoolLevelLbl: UILabel!
    
    /// Label to show the School Type
    @IBOutlet weak var schoolTypeLbl: UILabel!
    
    /// Label to show the School Rank
    @IBOutlet weak var rankMovementLbl: UILabel!
    
    /// Label to show the School Phone Number
    @IBOutlet weak var phoneLbl: UILabel!
    
    /// Label to show the School Low Grade
    @IBOutlet weak var lowGradeLbl: UILabel!
    
    /// Label to show the School High Grade
    @IBOutlet weak var highGradeLbl: UILabel!
    
    /// Label to show the School Hours
    @IBOutlet weak var schoolHoursLbl: UILabel!

    /// Label to show the School Address
    @IBOutlet weak var addressLbl: UILabel!
    
    /// View load method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUI()
        
    }
    
    /// UI binding logics
    func setUI() {
        
        self.navigationItem.title = "School Details"
        
        /* Addiing All lbls to Array for changing Text color in future at a time */
        let lblsArray = [schoolLevelLbl, schoolTypeLbl, schoolHoursLbl, rankMovementLbl, phoneLbl, lowGradeLbl, highGradeLbl, addressLbl]
        
        for lbl in lblsArray {
            lbl?.textColor = UIColor.valueTextColor()
        }
        
        print((schoolObj.schoolName)!)
        
        /* Assigning data To UI */
        schoolNameLbl.text = (schoolObj.schoolName)!
        
        schoolTypeLbl.text = ((schoolObj?.isPrivate)! ? "Public" : "Private")
        schoolLevelLbl.text = (schoolObj?.schoolLevel)!
        rankMovementLbl.text = (schoolObj.rankMovement)!
        phoneLbl.text = (schoolObj.phone)!
        lowGradeLbl.text = (schoolObj.lowGrade)!
        highGradeLbl.text = (schoolObj.highGrade)!
        schoolHoursLbl.text = (schoolObj.privateHours)!
        
        addressLbl.text = (schoolObj.address)!.htmlToString
    }
    
    /// Method for the calling functionality
    /// - Parameter sender: sender object of the clicked control
    @IBAction func callTapped(_ sender: UIControl) {
        SharedManager.shared.call((schoolObj.phone)!)
    }
}

extension String {
    
    /// Helper method of *htmlToString* to convert the html to attributed string
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    /// Method to convert the html to attributed string
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}
