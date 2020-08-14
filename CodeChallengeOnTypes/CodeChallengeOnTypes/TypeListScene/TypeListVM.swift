//
//  TypeListVM.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 13/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import UIKit
import Alamofire

protocol TypeListDelegate: class {
    func onDataFetch()
    func noDataFound(errorMsg: String)
}

class TypeListVM: NSObject {
    
    weak var delegate: TypeListDelegate?
    var groups = [String? : [ChallengeDataClass]]()
    let dataManager = ChallengeDataManager()

    func getData() {
        
        AF.request("https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json").responseDecodable(of: [ChallengeDataClass].self) { [weak self] response in
            
            guard let data = response.value else {
                self?.delegate?.noDataFound(errorMsg: response.error.debugDescription)
                return
            }
            if let isDeleted = self?.dataManager.deleteAll(), isDeleted {
                debugPrint(isDeleted)
            }
            self?.saveData(record: data)
            self?.groupData(data)
        }
    }
    
    private func groupData(_ challengeData: [ChallengeDataClass]) {
        let groups = Dictionary(grouping: challengeData) {
            $0.type
        }
        self.groups = groups
        self.delegate?.onDataFetch()
    }
    
    func saveData(record: [ChallengeDataClass]) {
        dataManager.create(challengeData: record)
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])

    }
    
    func showOfflineData() {
        guard let data = dataManager.fetch() else {
            return
        }
        self.groupData(data)
    }
}
