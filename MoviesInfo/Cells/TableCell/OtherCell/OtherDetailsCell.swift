//
//  OtherDetailsCell.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 01/02/21.
//

import UIKit

class OtherDetailsCell: UITableViewCell {
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var value: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func updateMovie(data: MovieData) {
    title.text = data.title
    value.text = data.value
  }
}
