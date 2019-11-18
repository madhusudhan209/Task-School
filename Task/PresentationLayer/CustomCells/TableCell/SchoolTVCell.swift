//
//  CustomTVCell.swift
//  Task
//
//  Created by Madhusudhan on 13/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//

import UIKit

/**
 The purpose of the `SchoolTVCell` is to display the each school - Name, Type, Level
 
 There's a matching scene in the *Main.storyboard* file, and in that scene there is a `SchoolTVCell` with `UITableViewCell` design. Go to Interface Builder for details.
 
 The `SchoolTVCell` class is a subclass of the `UITableViewCell`.
 */
class SchoolTVCell: UITableViewCell {

    /// Label to show the School Name
    @IBOutlet weak var schoolNameLbl: UILabel!
    
    /// Static Label of the School Type
    @IBOutlet weak var schoolTypeStaticLbl: UILabel!
    
    /// Static Label to the School Level
    @IBOutlet weak var schoolLevelStaticLbl: UILabel!
    
    /// Label to show the School Type
    @IBOutlet weak var schoolTypeLbl: UILabel!
    
    /// Label to show the School Level
    @IBOutlet weak var schoolLevelLbl: UILabel!
    
    /// Method that hanlde as soon as the cell displayed, used for any declarations
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Method that hanlde as soon as the cell displayed, used for any declarations
    /// - Parameters:
    ///   - selected: selected boolean object
    ///   - animated: animated boolean object
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /// Getting school Model Object and Displaying school informatio in UI
    var schoolObj: SchoolList? {
        
        didSet {
            
            schoolNameLbl.textColor = UIColor.titleHeaderColor()
            schoolTypeLbl.textColor = UIColor.hintColor()
            schoolLevelLbl.textColor = UIColor.hintColor()
            
            schoolTypeLbl.textColor = UIColor.valueTextColor()
            schoolLevelLbl.textColor = UIColor.valueTextColor()
            
            schoolNameLbl.text = (schoolObj?.schoolName)!
            schoolTypeLbl.text = ":   " + ((schoolObj?.isPrivate)! ? "Public" : "Private")
            schoolLevelLbl.text = ":   " + (schoolObj?.schoolLevel)!
            
            print((schoolObj?.schoolName)!)
        }
        
    }

}
