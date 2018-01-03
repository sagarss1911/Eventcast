//
//  MKRightSideMenuCell.swift
//  HK.CO
//
//  Created by keyur on 2/1/18.
//  Copyright © 2018 jtechappz. All rights reserved.
//

import UIKit

class MKRightSideMenuCell: UITableViewCell {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var imageName: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.font = UIFont.boldSystemFont(ofSize: 15.0)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
