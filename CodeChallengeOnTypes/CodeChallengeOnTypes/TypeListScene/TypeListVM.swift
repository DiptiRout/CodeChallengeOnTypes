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

    /// Get JSON data using Alamofire request.
    func getData() {
        
        AF.request("https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json").responseDecodable(of: [ChallengeDataClass].self) { [weak self] response in
            
            guard let data = response.value else {
                self?.delegate?.noDataFound(errorMsg: response.error.debugDescription)
                return
            }
            if let isDeleted = self?.dataManager.deleteAll(), isDeleted {
                debugPrint(isDeleted)
            }
            self?.mapImageData(data: data)
            self?.groupData(data)
        }
    }
    
    /// This method groups the data to create main screen UI of application.
    private func groupData(_ challengeData: [ChallengeDataClass]) {
        let groups = Dictionary(grouping: challengeData) {
            $0.type
        }
        self.groups = groups
        DispatchQueue.main.async {
            self.delegate?.onDataFetch()
        }
    }
    
    /// Before saving the data this method maps the image data to data model.
    private func mapImageData(data: [ChallengeDataClass]) {
        var newData = [ChallengeDataClass]()
        newData = data
        
        let queue = OperationQueue()
        let blockOperation1 = BlockOperation {
            newData.forEach {
                if $0.type == "image" {
                    $0.imageData = $0.data?.getDataFromURL()
                }
            }
        }
        blockOperation1.completionBlock = { [weak self] in
            self?.saveData(record: data)
        }
        queue.addOperation(blockOperation1)
    }
    
    /// Saves the data using core data and prints a path of the .sqlite file.
    func saveData(record: [ChallengeDataClass]) {
        dataManager.create(challengeData: record)
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        debugPrint(paths[0])
    }
    
    /// This will get called when application is in offline mode/
    func showOfflineData() {
        guard let data = dataManager.fetch() else {
            return
        }
        self.groupData(data)
    }
    
    /// This method observes the network change of the application.
    /// This will not work for Simultors.
    func observeNetworkChange() {
        NetworkReachability.shared.netStatusChangeHandler = {
            
            let networkType = NetworkReachability.shared.interfaceType
            
            if networkType == nil {
                self.showOfflineData()
            }
        }
    }
    
    
}
