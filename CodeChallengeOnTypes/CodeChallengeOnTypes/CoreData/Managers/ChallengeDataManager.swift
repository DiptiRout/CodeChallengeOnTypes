//
//  ChallengeDataManager.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 14/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import Foundation

/// This structure will communicate with the other class and handle data exchanging.
struct ChallengeDataManager
{
    private let _dataRepository = ChallengeDataRepository()

    /// Create entity using core data.
    func create(challengeData: [ChallengeDataClass]) {
        return _dataRepository.create(record: challengeData)
        
    }

    /// Fetch entity using core data.
    func fetch() -> [ChallengeDataClass]? {
        return _dataRepository.getAll()
    }
    
    /// Delete entity using core data.
    func deleteAll() -> Bool {
        return _dataRepository.deleteAll()
    }
}

