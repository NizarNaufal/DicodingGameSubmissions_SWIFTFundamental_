//
//  RawTableViewCell.swift
//  DicodingGameSubmissions
//
//  Created by nizar on 24/02/21.
//

import UIKit

class RawTableViewCell: UITableViewCell {

    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var gamePoster: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    @IBOutlet weak var gameReleasedDates: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
