//
//  MahallelerCollectionViewCell.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 7.02.2024.
//

import UIKit

class MahallelerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var backGround: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backGround.backgroundColor = .black
        backGround.layer.cornerRadius = 12
        titleLabel.textColor = .white
        
    }
    
    
    
}
