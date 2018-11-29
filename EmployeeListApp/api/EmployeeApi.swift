//
//  EmployeeApi.swift
//  EmployeeListApp
//
//  Created by Erkut Demirhan on 26/11/2018.
//  Copyright © 2018 Erkut Demirhan. All rights reserved.
//

import Foundation

class EmployeeApi {
    
    typealias resultHandler<T> = (_ result: T?, _ error: Error?) -> Void
    
    let apiUrlStr = "https://api.myjson.com/bins/ebel2"
    var session: UrlSessionProtocol
    
    init(session: UrlSessionProtocol) {
        self.session = session
    }
    
    func loadEmployees(resultHandler: @escaping resultHandler<[Employee]>) {
        let url = NSURL(string: apiUrlStr)! as URL
        let urlRequest = NSURLRequest(url: url)
        let dataTask = session.dataTask(with: urlRequest, completionHandler: {data, response, error in
            
            if(error != nil) {
                DispatchQueue.main.async {
                    resultHandler(nil, error)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                if let data = data {
                    let employeeList = try decoder.decode([Employee].self, from: data)
                    DispatchQueue.main.async {
                        resultHandler(employeeList, nil)
                    }
                }
            } catch let error {
                DispatchQueue.main.async {
                    resultHandler(nil, error)
                }
            }
        })
        
        dataTask.resume()
    }
    
}
