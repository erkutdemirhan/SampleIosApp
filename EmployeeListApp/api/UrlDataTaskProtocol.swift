//
//  UrlDataTaskProtocol.swift
//  EmployeeListApp
//
//  Created by Erkut Demirhan on 26/11/2018.
//  Copyright © 2018 Erkut Demirhan. All rights reserved.
//

import Foundation

public protocol UrlDataTaskProtocol {
    func resume() -> Void
}

extension URLSessionDataTask: UrlDataTaskProtocol {}
