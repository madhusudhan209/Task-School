//
//  CommonMethods.swift
//  Task
//
//  Created by Madhusudhan on 12/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

/** For Displaying Alert based on Validations, Information Or Getting error's from Web API
 
 - Parameters:
 - alertMessage: Alert Message
 */
func showAlert(_ alertMessage: String) {
    
    DispatchQueue.main.async(execute: {
        
        let alert = UIAlertController(title: "", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
    })
}

// MARK: -
/**
 Method for showing activity indicator while getting data from web api.
 */
func showActivity() {
    MBProgressHUD.showAdded(to: (appDelegate.window)!, animated: true)
    appDelegate.window?.rootViewController?.view.bringSubviewToFront(MBProgressHUD())
}

/**
 Method for hiding activity indicator after downloading data from web api.
 */
func hideActivity() {
    
    DispatchQueue.main.async(execute: {
        
        MBProgressHUD.hide(for: (appDelegate.window)!, animated: false)
    })
}

/// internet connectivity status label
var kNoConnectivityLabel : UILabel!


/// Adding Label if Internet is not available.
func addNoInternetConnectionLabel() {
    
    if  kNoConnectivityLabel == nil {
        kNoConnectivityLabel = UILabel(frame: CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 0))
        kNoConnectivityLabel.backgroundColor = UIColor.red
        kNoConnectivityLabel.text = "No Internet Connection"
        kNoConnectivityLabel.textColor = UIColor.white
        kNoConnectivityLabel.textAlignment = .center
        appDelegate.window?.rootViewController?.view.addSubview(kNoConnectivityLabel)
    }
    
    appDelegate.window?.rootViewController?.view.bringSubviewToFront(kNoConnectivityLabel)
    
    UIView.animate(withDuration: 1.0, animations: {
        var frame = kNoConnectivityLabel.frame
        frame.origin.y = SCREEN_HEIGHT-40
        frame.size.height = 40
        kNoConnectivityLabel.frame = frame;
    }, completion: { (_) in
        
    })
}
