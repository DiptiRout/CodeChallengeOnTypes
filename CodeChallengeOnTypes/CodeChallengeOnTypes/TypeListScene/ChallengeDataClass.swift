//
//  ChallengeDataClass.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 14/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import UIKit

public class ChallengeDataClass: NSObject, NSCoding, Decodable {
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(type, forKey: "type")
        coder.encode(date, forKey: "date")
        coder.encode(data, forKey: "data")
    }
    
    public required convenience init?(coder: NSCoder) {
        let id = coder.decodeObject(forKey: "id") as? String ?? "NA"
        let type = coder.decodeObject(forKey: "type") as? String ?? "NA"
        let date = coder.decodeObject(forKey: "date") as? String ?? "NA"
        let data = coder.decodeObject(forKey: "data") as? String ?? "NA"
        self.init(id: id, type: type, date: date, data: data)
    }
    
    
    var id: String?
    var type: String?
    var date: String?
    var data: String?
    
    init(id: String, type: String, date: String, data: String) {
        self.id = id
        self.type = type
        self.date = date
        self.data = data
    }
}
