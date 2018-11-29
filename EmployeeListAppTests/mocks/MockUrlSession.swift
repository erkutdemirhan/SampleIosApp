//
//  MockUrlSession.swift
//  EmployeeListAppTests
//
//  Created by Erkut Demirhan on 26/11/2018.
//  Copyright © 2018 Erkut Demirhan. All rights reserved.
//

import Foundation
@testable import EmployeeListApp

class MockUrlSession: UrlSessionProtocol {
    var nextDataTask = MockUrlSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    private (set) var latestUrl: URL?
    
    func dataTask(with request: NSURLRequest, completionHandler: @escaping UrlSessionProtocol.DataTaskResult) -> UrlDataTaskProtocol {
        latestUrl = request.url
        completionHandler(nextData, nil, nextError)
        return nextDataTask
    }
    
}
