//
//  ChallengeDataManager.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 14/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import Foundation

struct ChallengeDataManager
{
    private let _dataRepository = ChallengeDataRepository()

    func create(challengeData: [ChallengeDataClass]) {
        return _dataRepository.create(record: challengeData)
        
    }

    func fetch() -> [ChallengeDataClass]? {
        return _dataRepository.getAll()
    }
    
    func deleteAll() -> Bool {
        return _dataRepository.deleteAll()
    }
}

