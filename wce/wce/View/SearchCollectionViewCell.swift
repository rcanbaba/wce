//
//  SearchCollectionViewCell.swift
//  wce
//
//  Created by Can Babaoğlu on 2.11.2022.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    public lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blue
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureUI () {
        self.contentView.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
    
    
}
