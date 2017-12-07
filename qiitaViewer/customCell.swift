//
//  customCell.swift
//  qiitaViewer
//
//  Created by Atsushi KONISHI on 2017/12/07.
//  Copyright © 2017年 小西篤志. All rights reserved.
//

import UIKit

class customCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        // おそらくcell選択時の画面遷移
    }
    
    func setCell(title: String, name: String, tags: [String]) {
        titleLabel.text = title
        nameLabel.text = "Writer: " + name
        tagsLabel.text = "Tags: " + tags.reduce("") { $0 + ", " + $1 }
    }

}
