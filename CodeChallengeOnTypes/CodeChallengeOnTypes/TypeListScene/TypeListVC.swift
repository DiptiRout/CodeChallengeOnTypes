//
//  ViewController.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 13/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import UIKit

class TypeListVC: UICollectionViewController {
    
    //MARK : Properites
    let cellId = "Cell"
    private let viewModel = TypeListVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        if NetworkReachability.shared.isConnected {
            viewModel.getData()
        }
        else {
            viewModel.showOfflineData()
        }
        setupCollectionView()
        setupNavigationBarController()
    }
    
    //MARK : Setup Methods
    fileprivate func setupNavigationBarController() {
        navigationItem.title = "Lists"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func setupCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.alwaysBounceVertical = true
    }
    
    
    //MARK : - Actions
    @objc func editCellButton() {
        print("Edit")
    }

}

extension TypeListVC: TypeListDelegate {
    func noDataFound(errorMsg: String) {
        debugPrint("Error")
    }
    
    func onDataFetch() {
        collectionView.reloadData()
    }
}


extension TypeListVC: UICollectionViewDelegateFlowLayout {
    
    //MARK : CollectionView Delegate Methods
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.groups.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainCollectionViewCell
        cell.editButton.addTarget(self, action: #selector(editCellButton), for: .touchUpInside)
        let keys = Array(viewModel .groups.keys)
        cell.listNameLabel.text = keys[indexPath.item] ?? "NA"
        cell.iconImageView.image = UIImage(named: "Folder")
        
        cell.editButton.tag = indexPath.row
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let aGroup = Array(viewModel .groups)[indexPath.item]
        
        if let key = aGroup.key, key == "image" {
            let vc = TypeDetailsVC()
            vc.navTitle = aGroup.key ?? ""
            vc.challengeData = aGroup.value
            vc.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            let vc = TypeDetailsTextVC()
            vc.navTitle = aGroup.key ?? ""
            vc.challengeData = aGroup.value
            vc.navigationItem.largeTitleDisplayMode = .never
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 20, height: 110)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

}
