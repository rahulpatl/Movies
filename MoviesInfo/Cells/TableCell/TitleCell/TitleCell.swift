//
//  TitleCell.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 01/02/21.
//

import UIKit

class TitleCell: UITableViewCell {
  @IBOutlet weak var movieTitle: UILabel!
  @IBOutlet weak var movieOriginalTitle: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  func setUp(data: MovieData) {
    movieTitle.text = data.title
    movieOriginalTitle.text = data.title != data.value ? data.value : nil
  }
}
