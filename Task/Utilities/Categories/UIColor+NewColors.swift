//
//  UIColor+NewColors.swift
//  Task
//
//  Created by Madhusudhan on 12/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//

/*: 
 
 #Table of contents
 
 * hercBlackTitleHeaderColor
 * orangeBurBankColor
 
 
 #overview
 
 This file maintaining application Text colour, Background of selected and unselected color.
 
 */

import Foundation
import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red:r/255 ,green: g/255,blue: b/255, alpha: 1.0)
    }
    
    
    /** School Name Text Color
     
     - Returns: UIColor with RGB
     */
    public class func titleHeaderColor () -> UIColor {
        let headerColor = UIColor(red: 23.0/255.0, green: 85.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        return headerColor
    }
    
    /** Hint Color for UILabel
     
     - Returns: UIColor with RGB
     */
    public class func hintColor () -> UIColor {
        let leftColor = UIColor(red: 122/255.0, green: 122/255.0, blue: 122/255.0, alpha: 1.0)
        return leftColor
    }
    
    /** Text Color for UILabel
     
     - Returns: UIColor with RGB
     */
    public class func valueTextColor () -> UIColor {
        let leftColor = UIColor.black
        return leftColor
    }
    
}
