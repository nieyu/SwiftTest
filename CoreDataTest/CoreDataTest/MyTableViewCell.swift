//
//  MyTableViewCell.swift
//  CoreDataTest
//
//  Created by nie yu on 2020/1/13.
//  Copyright © 2020 nie yu. All rights reserved.
//

import UIKit

public class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.green
    }


    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
