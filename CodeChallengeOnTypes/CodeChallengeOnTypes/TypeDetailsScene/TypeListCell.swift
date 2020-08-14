//
//  TypeListCell.swift
//  CodeChallengeOnTypes
//
//  Created by Diptiranjan Rout on 13/08/20.
//  Copyright © 2020 Diptiranjan Rout. All rights reserved.
//

import UIKit

class TypeListCell: UICollectionViewCell {
        
    lazy var mainImageView:UIImageView = {
        let iv = UIImageView(frame:.zero)
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
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

    
    override func layoutSubviews() {
        super.layoutSubviews()
      
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)

        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor(r: 43, g: 45, b: 63)

        self.addSubview(self.mainImageView)
        self.addSubview(self.idString)
        self.addSubview(self.dateString)

        
        self.mainImageView.snp.remakeConstraints {
            $0.top.equalTo(self.snp.top)
            $0.left.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(160)
        }
        
        self.idString.snp.remakeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(4)
            $0.left.equalTo(16)
            $0.width.equalTo(self.frame.width - 32)
            $0.height.equalTo(25)
        }
        
        self.dateString.snp.remakeConstraints {
            $0.top.equalTo(idString.snp.bottom)
            $0.left.equalTo(16)
            $0.width.equalTo(self.frame.width - 32)
            $0.height.equalTo(25)
        }
    }
    
    func setupData(data: ChallengeDataClass) {
        idString.text = "Image ID: \(data.id ?? "")"
        dateString.text = "Image Date: \(data.date ?? "")"
        guard let url = URL(string: data.data ?? "") else {
            return
        }
        mainImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "Folder"))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
