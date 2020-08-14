//
//  TypeTextCell.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 13/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import UIKit

class TypeTextCell: UITableViewCell {
    
    static let ID = "TypeTextCell"
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(r: 43, g: 45, b: 63)
        return view
    }()
    
    lazy var idString: UILabel = {
        let id = UILabel()
        id.textColor = .white
        id.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return id
    }()
    
    lazy var dateString: UILabel = {
        let date = UILabel()
        date.textColor = UIColor(r: 102, g: 104, b: 124)
        date.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return date
    }()
    
    lazy var dataString: UILabel = {
        let date = UILabel()
        date.numberOfLines = 0
        date.textColor = UIColor(r: 171, g: 107, b: 97)
        date.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return date
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(self.containerView)
        containerView.addSubview(self.idString)
        containerView.addSubview(self.dateString)
        containerView.addSubview(self.dataString)
        
        self.containerView.snp.remakeConstraints {
            $0.left.equalToSuperview().offset(8)
            $0.right.equalToSuperview().offset(-8)
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
        }
        
        self.idString.snp.remakeConstraints {
            $0.top.equalTo(containerView.snp.top).offset(12)
            $0.left.equalTo(containerView.snp.left).offset(8)
            $0.right.equalTo(containerView.snp.right).offset(-8)
        }
        
        self.dateString.snp.remakeConstraints {
            $0.top.equalTo(idString.snp.bottom).offset(4)
            $0.left.equalTo(containerView.snp.left).offset(8)
            $0.right.equalTo(containerView.snp.right).offset(-8)
        }
        
        self.dataString.snp.remakeConstraints {
            $0.top.equalTo(dateString.snp.bottom).offset(4)
            $0.left.equalTo(containerView.snp.left).offset(8)
            $0.right.equalTo(containerView.snp.right).offset(-8)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-12)
        }
    }
    
    func setupData(data: ChallengeDataClass) {
        idString.text = "Text ID: \(data.id ?? "-")"
        dateString.text = "Text Date: \(data.date ?? "-")"
        dataString.text = data.data
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
