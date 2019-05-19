
//
//  DataTableViewCell.swift
//  8080
//
//  Created by shahid mohd on 19/05/19.
//  Copyright © 2019 shahidmohd. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var fileName: UILabel!
    
    @IBOutlet weak var fileSize: UILabel!
    
    @IBOutlet weak var fileSeed: UILabel!
    
    @IBOutlet weak var fileSpeedUpload: UILabel!
    @IBOutlet weak var fileSpeedDownload: UILabel!
    @IBOutlet weak var filePeer: UILabel!
    @IBOutlet weak var fileUploaded: UILabel!
    
    @IBOutlet weak var fileAdded: UILabel!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var fileStatus: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
