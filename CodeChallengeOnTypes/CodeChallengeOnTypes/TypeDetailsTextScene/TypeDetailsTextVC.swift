//
//  TypeDetailsTextVC.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 13/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import UIKit


protocol ChallaengeDelegate: class {
    func refreshData(id: String)
}


class TypeDetailsTextVC: UITableViewController {

    var navTitle = ""
    var challengeData = [ChallengeDataClass]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        setupNavigationBarController()
        setupTableView()
    }
    
    //MARK : Setup Methods
    fileprivate func setupNavigationBarController() {
        self.navigationItem.title = navTitle
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func setupTableView() {
        tableView.register(TypeTextCell.self, forCellReuseIdentifier: TypeTextCell.reuseID)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 150
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TypeTextCell.reuseID, for: indexPath) as! TypeTextCell
        cell.setupData(data: challengeData[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsVC()
        vc.challengeData = challengeData[indexPath.row]
        vc.viewModel.cDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension TypeDetailsTextVC: ChallaengeDelegate {
    func refreshData(id: String) {
        
        let alert = UIAlertController(title: "Removed", message: "Text component with id: \(id) has been removed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        
        }))
        
        self.present(alert, animated: true, completion: nil)
        
        let data = challengeData.filter {
            $0.id != id
        }
        challengeData = data
        tableView.reloadData()
    }
}
