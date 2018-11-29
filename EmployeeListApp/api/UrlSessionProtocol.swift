//
//  UrlSessionProtocol.swift
//  EmployeeListApp
//
//  Created by Erkut Demirhan on 26/11/2018.
//  Copyright © 2018 Erkut Demirhan. All rights reserved.
//

import Foundation

protocol UrlSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func dataTask(with request: NSURLRequest, completionHandler: @escaping DataTaskResult) -> UrlDataTaskProtocol
}

extension URLSession: UrlSessionProtocol {
    func dataTask(with request: NSURLRequest, completionHandler: @escaping UrlSessionProtocol.DataTaskResult) -> UrlDataTaskProtocol {
        return dataTask(with: request as URLRequest, completionHandler: completionHandler)
    }
    
}

