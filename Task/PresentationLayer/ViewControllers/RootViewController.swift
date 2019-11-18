//
//  RootViewController.swift
//  Task
//
//  Created by Madhusudhan on 13/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//

import UIKit

/**
 The purpose of the `RootViewController` is to fetch the schools list from the api and display the details on a tableview cell
 
 There's a matching scene in the *Main.storyboard* file, and in that scene there is a `UITableView` with `UITableViewCell` design. Go to Interface Builder for details.
 
 The `RootViewController` class is a subclass of the `UIViewController`, and it conforms to the `UITableViewDataSource`, `UITableViewDelegate` and `UIScrollViewDelegate`  protocol.
 */
class RootViewController: UIViewController {
    
    /// object that holds Page number of the API
    var currentPageIndex = 1
    
    /// object that holds total service call requests
    var totalPages = 0
    
    /// object that holds service call per page request
    var perPage = 10
    
    /// array object that holds table data
    var schoolListArray = [SchoolList]()
    
    /// tableview for displaying the schools list
    @IBOutlet weak var schoolListTableView: UITableView!
    
    /// label for displaying the message if there is no data
    @IBOutlet weak var noDataLbl: UILabel!

    /// View load method
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /* Getting School List From Database */
        schoolListArray = SharedManager.shared.getSchoolListFromDatabase()
        
        /* If data is empty in database then call api to get the data */
        if schoolListArray.count == 0 {
            getSchoolListFromApi()
        }
        else {

            /* Get round  value for calling api */
            let currentPage: CGFloat = ((CGFloat(schoolListArray.count))/CGFloat(perPage)).rounded()
            print(currentPage)
            currentPageIndex = Int((currentPage+1))
            print(currentPageIndex)
        }
        
    }
    
    /**
     Schools list API calling
     */
    func getSchoolListFromApi() {
                
        let url = SCHOOLSLIST_URL + "?st=\("CA")&page=\(currentPageIndex)&perPage=\(perPage)&appID=\(APP_ID)&appKey=\(APP_KEY)"
        
        ServiceManager.shared.callToGetDataFromServer(appendUrlString: url, withIndicator: currentPageIndex == 1 ? true : false, completionHandler: { (jsonOutput) in
            
            self.dataBindingToModel(String.checkDictionary(jsonOutput as Any))

        })
    }
    
    /** Api Response Binding to SchoolList Model Class And checking whether Array count is empty or not
     
     If *SchoolLIstArray* does not have values then showing Label No Data Available, If *SchoolListArray* does have values then hidding NoDataLbl and Displaying TableView and Reloading the TableView to Load data in TableView cells UI
     
     - Parameter jsonDictionary: Response json object
     */
    func dataBindingToModel(_ jsonDictionary: NSDictionary) {
        
        let payloadArray = String.checkArray(jsonDictionary["schoolList"] as Any)

        if self.currentPageIndex == 1 {
            self.schoolListArray.removeAll()
            self.schoolListTableView.contentOffset = CGPoint(x: 0, y: 0)
        }
        
        /* Getting total Results count and increasing pagenumber */
        if payloadArray.count != 0 {
            self.currentPageIndex = self.currentPageIndex+1
            self.totalPages = Int(String.checkNSNumberNull(jsonDictionary["numberOfPages"] as Any))!
        }
        
        print(payloadArray.count)
        
        // insert each item into database
        for i in 0..<payloadArray.count {
            let schoolObj = SchoolList(dict: payloadArray.object(at: i) as! [String : Any])
            SharedManager.shared.insertSchoolinDataBase(schoolObj)
        }
        
        self.schoolListArray = SharedManager.shared.getSchoolListFromDatabase()
        
        #if DEDEBUG
        print(self.schoolListArray)
        #endif
        
        SharedManager.shared.showTableOrNoData(self.noDataLbl, tableView: self.schoolListTableView, count: self.schoolListArray.count)
        
    }
}

// MARK: - TableView DataSource and Delegate Methods
extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// To display the number of sections for table
    /// - Parameter tableView: tableView object that displays schools list
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// To display number of rows in each section of table
    /// - Parameters:
    ///   - tableView: tableView object that displays schools list
    ///   - section: current section index
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolListArray.count
    }
    
    /// To set the values for fields on the each cell of the row
    /// - Parameters:
    ///   - tableView: tableView object that displays schools list
    ///   - indexPath: current indexpath object
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom_CellID", for: indexPath) as! SchoolTVCell
        cell.selectionStyle = .none
        cell.schoolObj = schoolListArray[indexPath.row]
        
        return cell
    }
    
    /// Click action delegate of table view row.
    /// - Parameters:
    ///   - tableView: tableView object that displays schools list
    ///   - indexPath: current indexpath object
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* navigating to SchoolDetailsViewController Screen to display about school details */
        self.performSegue(withIdentifier: DETAILS_IDENTIFIER, sender: schoolListArray[indexPath.row])
    }
    
    /// Methods as soon as the cell is displayed
    /// - Parameters:
    ///   - tableView: tableView object that displays schools list
    ///   - cell: current cell object
    ///   - indexPath: current indexpath object
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /* Pagination applied */
        SharedManager.shared.showIndicatorForPaginationTableView(tableView, forRowAt: indexPath, perPage: perPage)
    }
    
}

// MARK: - ScrollView Delegate Methods
extension RootViewController: UIScrollViewDelegate {
    
    /// This is for calling APi with increasing of pagination if User showing last results in TableView
    ///
    /// - Parameter scrollView: Default TableView
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y + scrollView.frame.size.height >= scrollView.contentSize.height {
            
            getSchoolListFromApi()

        }
    }
    
}




