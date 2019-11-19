//
//  ServiceManager.swift
//  Task
//
//  Created by Madhusudhan on 14/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//


import UIKit

/**
 The purpose of the `ServiceManager` is to Calling web API calls and sending downloaded Web API Data to Respected class with help of call back funtion.
 
 The `ServiceManager` class is a subclass of the `NSObject`,
 */
class ServiceManager: NSObject {
    
    /// shared object of the singleton class `ServiceManager`
    @objc class var shared : ServiceManager{
        
        struct singleton{
            static let instance = ServiceManager()
        }
        return singleton.instance
    }
    
    
    /** Calling WebService API For downloading the data from Web Server
     
     1. Checking whether the `url` is getting empty or not. If it is not empty assigning required thigs to the URLRequest for getting data from Web Server
     2.
     - Parameters:
     - appendUrlString: Web Api Link
     - withIndicator: This is boolean condition whether do we want to show activity indicator in full screen or not
     - completionHandler: For call back funtion after Receiving response from APi
     */
    @objc func callToGetDataFromServer(appendUrlString: String, withIndicator: Bool = true, completionHandler: @escaping CompletionHandler) {
        
        /// getting url into local instance for replacing %20 in place of spaces are available in the web API
        var urlString = appendUrlString
        urlString = urlString.replacingOccurrences(of: " ", with: "%20")
        
        #if DEDEBUG
        print(urlString)
        #endif
        
        
        if let url = URL(string: urlString) {
            
            if !checkInternetAvailability() {
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if withIndicator == true {
                    showActivity()
                }
            })
            
            var urlRequest = URLRequest(url: url)
            // Set the API TYPE for Request
            urlRequest.httpMethod = HttpMethod.GET.rawValue
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
                
                DispatchQueue.main.async(execute: {
                    hideActivity()
                })
                
                //Displaying error message in UIAlertController may be appropriate here rather than just a console log and an abort
                if error != nil {
                    print("fail to connect with error:\(String(describing: error?.localizedDescription))")
                    showAlert((error?.localizedDescription)!)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 200 {
                        
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options:[])
                            
                            #if DEDEBUG
                            print(json)
                            #endif
                            
                            DispatchQueue.main.async {
                                completionHandler(json)
                            }
                            
                        }
                        catch {
                            DispatchQueue.main.async {
                                showAlert(kWrongMessage)
                            }
                            
                            print("failed to Get Data from Server with error:%@",error)
                        }
                        
                    }
                    else {
                        print("error \(httpResponse.statusCode)")
                    }
                }
                
            }).resume()
            
        }
    }
    
    
    /** Checking internet availability
     
     If it is Internet doest not available then showing Label from bottom side with animation
     
     - Returns: true or false
     */
    func checkInternetAvailability() -> Bool {
        
        if appDelegate.internetAvailability == false {
            addNoInternetConnectionLabel()
            return false
        }
        else {
            
            if kNoConnectivityLabel != nil {
                if kNoConnectivityLabel.frame.size.height == 40 {
                    UIView.animate(withDuration: 60.0, animations: {
                        
                    }, completion: { (_) in
                        
                        UIView.animate(withDuration: 1.0, animations: {
                            var frame = kNoConnectivityLabel.frame
                            frame.origin.y = SCREEN_HEIGHT
                            frame.size.height = 0
                            kNoConnectivityLabel.frame = frame;
                        }, completion: { (_) in
                            
                        })
                    })
                }
            }
        }
        
        return true
    }
    
}
