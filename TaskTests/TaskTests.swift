//
//  TaskTests.swift
//  TaskTests
//
//  Created by Madhusudhan on 12/11/19.
//  Copyright © 2019 MyDoc. All rights reserved.
//

import XCTest
@testable import Task

class TaskTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    /// checking for saving empty school information in Database
    func testInsetringEmptySchoolList() {
        let schoolList1 = SharedManager.shared.getSchoolListFromDatabase()
        let school = SchoolList(dict: [:])
        print("------>",schoolList1.count)
        SharedManager.shared.insertSchoolinDataBase(school)
        let schoolList2 = SharedManager.shared.getSchoolListFromDatabase()
        print("------>",schoolList2.count)
        XCTAssertEqual(schoolList1.count + 1, schoolList2.count)
    }
    
    func testInsetringOneSchoolList() {
        let schoolList1 = SharedManager.shared.getSchoolListFromDatabase()
        let _ = ""
        let school = SchoolList(dict: [:])
        school.address = nil
        school.highGrade = nil
        school.schoolID = nil
        school.schoolName = nil
        
        print("------>",schoolList1.count)
        SharedManager.shared.insertSchoolinDataBase(school)
        let schoolList2 = SharedManager.shared.getSchoolListFromDatabase()
        print("------>",schoolList2.count)
        XCTAssertEqual(schoolList1.count + 1, schoolList2.count)
        
    }
    
    func testInsetringActualData() {
        let schoolList1 = SharedManager.shared.getSchoolListFromDatabase()
        let school = SchoolList(dict: [:])
        school.address = "Hyderabad"
        school.highGrade = "A+"
        school.schoolID = "1234"
        school.schoolName = "Primary School"
        
        print("------>",schoolList1.count)
        SharedManager.shared.insertSchoolinDataBase(school)
        let schoolList2 = SharedManager.shared.getSchoolListFromDatabase()
        print("------>",schoolList2.count)
        XCTAssertEqual(schoolList1.count + 1, schoolList2.count)
        
    }
    
    func testCheckNullValueWithInt() {
        let testString =  String.checkNSNumberNull(123)
        XCTAssertEqual("123", testString)
    }
    
    func testCheckNullValueWithAny() {
        let testString = String.checkNSNumberNull(NSNull())
        XCTAssertEqual("", testString)
    }

}
