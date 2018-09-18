//
//  ViewController.swift
//  ObjectsWithStaticHosting
//
//  Created by Tim Beals on 2018-09-17.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        APIService.fetchData(with: .json) { (data, error) in

            guard error == nil else { print(error!.localizedDescription); return }

            if let unwrappedData = data {
                
                print("Data String: \(String(data: unwrappedData, encoding: .utf8)!)")

                let people = Person.getPeople(from: unwrappedData)
                
                for person in people {
                    print(person)
                }
                
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
