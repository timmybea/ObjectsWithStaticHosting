//
//  Person.swift
//  ObjectsWithStaticHosting
//
//  Created by Tim Beals on 2018-09-17.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import Foundation


struct Employee : Decodable {
    
    var email: URL
    var firstName: String
    var id: Int
    var lastName: String
    var imageURLEndPoint
    
    enum EmployeeKeys: String, CodingKey {
        case email = "email"
        case firstName = "first_name"
        case id = "id"
        case lastName = "last_name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: EmployeeKeys.self)
        let firstName = try container.decode(String.self, forKey: .firstName)
        let email = try container.decode(URL.self, forKey: .email)
        let id = try container.decode(Int.self, forKey: .id)
        let lastName = try container.decode(String.self, forKey: .lastName)
        
        self.init(email: email, firstName: firstName, lastName: lastName, id: id)
    }
    
    init(email: URL, firstName: String, lastName: String, id: Int) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }
    
}

extension Employee : CustomStringConvertible {
    
    var description: String {
        return "My name is \(firstName) \(lastName). My id is \(id) and my email is \(email)"
    }
    
}
