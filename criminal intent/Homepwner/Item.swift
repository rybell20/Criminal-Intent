//
//  Item.swift
//  Homepwner
//
//  Created by Bell, Ryan J. on 11/29/17.
//  Copyright © 2017 Bell, Ryan J. All rights reserved.
//

import Foundation

class Item: NSObject{
    
    var name: String
    var solved: String
    var serialNumber: String
    var dateCreated: Date
    let itemKey: String
    
    init(name: String, serialNumber: String, solved: String) {
        
        self.name = name
        self.solved = solved
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        super.init()
        
    }
    
    convenience init(random: Bool = false) {
        
        if random {
            let adjectives = ["Mike", "Rusty", "Joro"]
            let nouns = ["Ate the Pie", "Stole the Cash", "Drank the Juice"]
            let solved = ["SOLVED", "UNSOLVED"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            idx = arc4random_uniform(UInt32(solved.count))
            let finalSolved = solved[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomSolved = "\(finalSolved)"
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName,
                      serialNumber: randomSerialNumber,
                      solved: randomSolved)
        } else {
            self.init(name: "", serialNumber: "", solved: "")
        }
    }
    

}
