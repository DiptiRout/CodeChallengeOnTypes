//
//  ChallengeDataRepository.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 14/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import Foundation
import SDWebImage
import CoreData


struct ChallengeDataRepository: BaseRepository {

    func create(record: [ChallengeDataClass]) {
        
        let cdChallenge = CDChallenge(context: PersistentStorage.shared.context)
        cdChallenge.challengeData = record
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [ChallengeDataClass]? {
        
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: CDChallenge.self)
        guard records != nil && records?.count != 0 else {return nil}
        
        var results: [ChallengeDataClass] = []
        records!.forEach{
            if let data = $0.challengeData {
                results.append(contentsOf: data)
            }
        }
        
        return results
    }
    
    func deleteAll() -> Bool {
        
        let records = getAllData()
        guard records != nil else {return false}
        
        PersistentStorage.shared.context.delete(records!)
        return true
    }
    
    private func getAllData() -> CDChallenge?
    {
        let fetchRequest = NSFetchRequest<CDChallenge>(entityName: "CDChallenge")
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            
            guard result != nil else {return nil}
            return result
            
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    typealias T = [ChallengeDataClass]
    
}
