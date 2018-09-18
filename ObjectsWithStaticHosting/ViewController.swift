//
//  ViewController.swift
//  ObjectsWithStaticHosting
//
//  Created by Tim Beals on 2018-09-17.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var people: [Person]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.frame = view.frame
        tv.register(PersonCell.self, forCellReuseIdentifier: PersonCell.reuseIdentifier)
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        APIService.fetchData(with: .json) { (data, error) in

            guard error == nil else { print(error!.localizedDescription); return }

            if let unwrappedData = data {
                
                print("Data String: \(String(data: unwrappedData, encoding: .utf8)!)")

                self.people = Person.getPeople(from: unwrappedData)
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        tableView.removeFromSuperview()
        
        view.addSubview(tableView)
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonCell.reuseIdentifier, for: indexPath) as! PersonCell
        cell.setup(for: self.people![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

