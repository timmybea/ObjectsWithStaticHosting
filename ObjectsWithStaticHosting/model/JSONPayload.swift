//
//  JSONPayload.swift
//  ObjectsWithStaticHosting
//
//  Created by Tim Beals on 2018-09-17.
//  Copyright © 2018 Roobi Creative. All rights reserved.
//

import Foundation

//struct JSONPayload : Decodable {
//    
//    let people: [Person]
//    
//    enum PayloadKeys: String, CodingKey {
//        case person = "person"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: PayloadKeys.self)
//        
//        var p = [Person]()
//        
//        if let people = try container.decodeIfPresent([Person].self, forKey: .person) {
//            p = people
//        }
//        
//        self.init(people: p)
//    }
//    
//    init(people: [Person]) {
//        self.people = people
//    }
//    
//}
