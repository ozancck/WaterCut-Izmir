//
//  WaterCutsHomeTableViewCell.swift
//  Su Gitti
//
//  Created by Ozan Çiçek on 7.02.2024.
//

import UIKit

class WaterCutsHomeTableViewCell: UITableViewCell {
    
    
  
    @IBOutlet weak var imageview: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var desc: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
