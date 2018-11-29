//
//  ViewController.swift
//  EmployeeListApp
//
//  Created by Erkut Demirhan on 21/11/2018.
//  Copyright © 2018 Erkut Demirhan. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {

    var employeeApi = EmployeeApi(session: URLSession.shared)
    var employeeList = [Employee]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        loadEmployees()
    }
    
    func loadEmployees() {
        employeeApi.loadEmployees { employees, error in
            
            if(error != nil) {
                print("Error occured: \(String(describing: error))")
                return
            }
            
            if let employees = employees {
                self.employeeList = employees
                self.tableView?.reloadData()
                self.tableView?.setContentOffset(CGPoint.zero, animated: false)
            }
        }
    }

}

extension EmployeeListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as! EmployeeTableViewCell
        
        let employee = employeeList[indexPath.row]
        
        cell.nameLabel.text = employee.name
        cell.companyLabel.text = employee.company
        
        guard let avatarUrlString = employee.avatarUrl else {
            return cell
        }
        
        let avatarURL = URL(string: avatarUrlString)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: avatarURL!)
            DispatchQueue.main.async {
                cell.avatarImageView?.image = UIImage(data: data!)
            }
        }
        
        return cell
    }
}

extension EmployeeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
}

