//
//  LoadEmployeesTest.swift
//  EmployeeListAppTests
//
//  Created by Erkut Demirhan on 26/11/2018.
//  Copyright © 2018 Erkut Demirhan. All rights reserved.
//

import XCTest
@testable import EmployeeListApp

enum MockError: Error {
    case mockError
    case defaultError
}

class LoadEmployeesTest: XCTestCase {
    
    var api: EmployeeApi?
    var session: MockUrlSession?
    
    override func setUp() {
        super.setUp()
        session = MockUrlSession()
        api = EmployeeApi(session: session!)
    }
    
    func testResumeCalled() {
        // when
        session?.nextDataTask = MockUrlSessionDataTask()
        
        // then
        api?.loadEmployees { employees, error in
        }
        
        // assert
        XCTAssertTrue((session?.nextDataTask.isResumeCalled)!)
    }
    
    func testSuccess() {
        // when
        let expectation = self.expectation(description: "Success")
        var checkError: Error?
        var checkData: [Employee]?
        session?.nextData = loadEmployeeData()! as Data
        
        // then
        api?.loadEmployees { employees, error in
            checkError = error
            checkData = employees
            expectation.fulfill()
        }
        
        // assert - wait 5 sec for expectation
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(checkError)
        XCTAssertNotNil(checkData)
        XCTAssertEqual(checkData?.count, 1)
    }
    
    func testSuccessParseData() {
        // when
        let expectation = self.expectation(description: "Success")
        var checkError: Error?
        var checkData: Employee?
        session?.nextData = loadEmployeeData()! as Data
        
        // then
        api?.loadEmployees { employees, error in
            checkError = error
            checkData = employees?[0]
            expectation.fulfill()
        }
        
        // assert - wait 5 sec for expectation
        waitForExpectations(timeout: 5, handler: nil)
        guard let employee = checkData else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(employee.name, "Donald Trump")
        XCTAssertEqual(employee.company, "WHITE HOUSE")
        XCTAssertEqual(employee.eyeColor, Employee.EyeColor.blue)
        XCTAssertEqual(employee.coordinates.latitude, 61.428201)
        XCTAssertEqual(employee.coordinates.longitude, -26.126379)
    }
    
    func testSuccessEmptyEmployeeList() {
        // when
        let expectation = self.expectation(description: "Success")
        var checkError: Error?
        var checkData: [Employee]?
        session?.nextData = loadEmployeeData(fileName: "employeeTestDataEmpty")! as Data
        
        // then
        api?.loadEmployees { employees, error in
            checkError = error
            checkData = employees
            expectation.fulfill()
        }
        
        // assert - wait 5 sec for expectation
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNil(checkError)
        XCTAssertNotNil(checkData)
        XCTAssertEqual(checkData?.count, 0)
    }
    
    func testError() {
        // when
        let expectation = self.expectation(description: "Error")
        let testError = MockError.mockError
        var checkError = MockError.defaultError
        var checkData: [Employee]?
        session?.nextError = testError
        
        // then
        api?.loadEmployees { employees, error in
            checkError = error as! MockError
            checkData = employees
            expectation.fulfill()
        }
        
        // assert - wait 5 sec for expectation
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(checkError, MockError.mockError)
        XCTAssertNil(checkData)
    }
    
    override func tearDown() {
        api = nil
        session = nil
        super.tearDown()
    }
    
    private func loadEmployeeData(fileName: String = "employeeTestData") -> NSData? {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: fileName, ofType: "json")!
        return try! NSData(contentsOfFile: path)
    }
    
}
