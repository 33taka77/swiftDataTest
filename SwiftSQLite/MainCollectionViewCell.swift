//
//  MainCollectionViewCell.swift
//  SwiftSQLite
//
//  Created by Aizawa Takashi on 2015/04/23.
//  Copyright (c) 2015年 Aizawa Takashi. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    func setupCell(title:String) {
        titleLabel.text = title
    }
}
