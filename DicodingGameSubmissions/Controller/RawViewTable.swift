//
//  RawViewTable.swift
//  DicodingGameSubmissions
//
//  Created by nizar on 23/02/21.
//

import SwiftUI

class RawViewTable: UITableViewCell {


    @IBOutlet weak var rawPoster: UIImageView!
    @IBOutlet weak var rawTitle: UILabel!
    @IBOutlet weak var rawRating: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
