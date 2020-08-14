//
//  ChallengeDataClass.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 14/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import UIKit

struct ChallengeDataClass: Decodable {
    let id: String?
    let type: String?
    let date: String?
    let data: String?
}

public class ChallengeDataClass: NSObject, Decodable {
    
    var id: String
    var type: String
    var date: String
    var data: String
    
    init(_id: String, _type: String, _date: String, _data: String) {
        id = _id
        type = _type
        date = _date
        data = _data
    }
}
