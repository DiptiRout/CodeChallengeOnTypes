//
//  ViewController.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 13/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import UIKit

class TypeListVC: UICollectionViewController {
    
    private let viewModel = TypeListVM()
    let activityView = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.observeNetworkChange()
        setupCollectionView()
        setupNavigationBarController()
        showLoader()
        if NetworkReachability.shared.isConnected {
            viewModel.getData()
        }
        else {
            viewModel.showOfflineData()
        }
       
    }
    
    //MARK : Setup Methods
    
    private func showLoader() {
        self.collectionView.backgroundView = activityView
        activityView.color = .black
        activityView.hidesWhenStopped = true
        activityView.center = self.collectionView.center
        activityView.startAnimating()
    }
    
    /// Customize the navigation bar.
    fileprivate func setupNavigationBarController() {
        navigationItem.title = "Lists"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    /// Setting the collection view.
    fileprivate func setupCollectionView() {
        view.backgroundColor = .white
        collectionView?.backgroundColor = .white
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.reuseID)
        collectionView.alwaysBounceVertical = true
    }
    
    
    //MARK : - Actions
    @objc func editCellButton() {
        debugPrint("Edit")
    }

}

extension TypeListVC: TypeListDelegate {
    
    //MARK : TypeList Delegate Methods

    func noDataFound(errorMsg: String) {
        DispatchQueue.main.async { [weak self] in
            self?.activityView.stopAnimating()
            debugPrint("Error")
        }
    }
    
    func onDataFetch() {
        DispatchQueue.main.async { [weak self] in
            self?.activityView.stopAnimating()
            self?.collectionView.reloadData()
        }
    }
    
    func becameOnline() {
        DispatchQueue.main.async { [weak self] in
            self?.activityView.startAnimating()
            self?.viewModel.getData()
        }
    }
}


extension TypeListVC: UICollectionViewDelegateFlowLayout {
    
    //MARK : CollectionView Delegate Methods
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.reuseID, for: indexPath) as! MainCollectionViewCell
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
