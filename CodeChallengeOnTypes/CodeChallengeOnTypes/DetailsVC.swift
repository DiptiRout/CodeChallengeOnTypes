//
//  DetailsVC.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 26/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import UIKit
import SnapKit




class DetailsVM: NSObject {
    weak var cDelegate: ChallaengeDelegate?
    
}



class DetailsVC: UIViewController {
    
    var challengeData: ChallengeDataClass?

    let containerView = UIView()
    let textLabel = UILabel()
    let removeButton = UIButton()
    let viewModel = DetailsVM()

    fileprivate func setupUI() {
        
        view.addSubview(containerView)
        containerView.addSubview(removeButton)

        containerView.snp.remakeConstraints {
            
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
        
        containerView.backgroundColor = .gray
        containerView.addSubview(textLabel)

        textLabel.snp.remakeConstraints {
            
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
            $0.top.equalToSuperview().offset(8)
            $0.bottom.equalTo(removeButton.snp.top)
        }

        
        textLabel.text = challengeData?.data
        textLabel.textColor = .white
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                
        removeButton.snp.remakeConstraints {
            
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-8)
        }

        removeButton.backgroundColor = .red
        removeButton.setTitle("Remove", for: .normal)
        removeButton.addTarget(self, action: #selector(remove), for: .touchUpInside)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = challengeData?.id

        setupUI()
        
    }
    
    
    @objc func remove() {
        
        self.navigationController?.popViewController(animated: true)
        viewModel.cDelegate?.refreshData(id: challengeData?.id ?? "")
    }
    

}
