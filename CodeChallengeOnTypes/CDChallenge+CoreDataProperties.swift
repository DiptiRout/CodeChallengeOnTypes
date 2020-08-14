//
//  CDChallenge+CoreDataProperties.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 14/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//
//

import Foundation
import CoreData


extension CDChallenge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDChallenge> {
        return NSFetchRequest<CDChallenge>(entityName: "CDChallenge")
    }

    @NSManaged public var challengeData: [ChallengeDataClass]?

}
