//
//  TypeDetailsVC.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 13/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class TypeDetailsVC: UIViewController {
    
    var navTitle = ""
    var challengeData = [ChallengeDataClass]()
    let cellLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var feedCV: UICollectionView!
    let headerView = UIView()
    
    fileprivate var headerViewHeight:CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarController()
        //setupUI()
        setupCV()
    }
    
    //MARK : Setup Methods
    fileprivate func setupNavigationBarController() {
        self.navigationItem.title = navTitle
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func setupCV() {
        // Cell Layout Sizes
        cellLayout.scrollDirection = .vertical
        cellLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        cellLayout.itemSize = CGSize(width: view.bounds.width - 32, height: 220)
        
        
        // CollectionView
        feedCV = UICollectionView(frame: .zero, collectionViewLayout: cellLayout)
        self.view.addSubview(feedCV)
        self.feedCV.snp.remakeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.left.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(view.snp.bottom)
        }
        
        feedCV.register(TypeListCell.self, forCellWithReuseIdentifier: TypeListCell.ID)
        
        feedCV.backgroundColor = .white
        feedCV.showsVerticalScrollIndicator = true
        feedCV.isScrollEnabled = true
        feedCV.bounces = true
        feedCV.delegate = self
        feedCV.dataSource = self
        
        
    }
    
    fileprivate func setupUI() {
        view.backgroundColor = .white
    }
}

extension TypeDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return challengeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TypeListCell.ID, for: indexPath) as! TypeListCell
        cell.setupData(data: challengeData[indexPath.item])
        return cell
        
    }    
}
