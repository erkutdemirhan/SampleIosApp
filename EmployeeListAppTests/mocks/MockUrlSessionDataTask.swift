//
//  MockUrlSessionDataTask.swift
//  EmployeeListAppTests
//
//  Created by Erkut Demirhan on 26/11/2018.
//  Copyright © 2018 Erkut Demirhan. All rights reserved.
//

import Foundation
@testable import EmployeeListApp

class MockUrlSessionDataTask: UrlDataTaskProtocol {
    private (set) var isResumeCalled = false
    
    func resume() {
        isResumeCalled = true
    }
}
