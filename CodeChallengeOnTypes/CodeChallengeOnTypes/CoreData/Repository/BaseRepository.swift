//
//  BaseRepository.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 14/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import Foundation

protocol BaseRepository {

    associatedtype T
    
    func create(record: T)
    func getAll() -> T?
    func deleteAll() -> Bool
}
