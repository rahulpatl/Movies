//
//  PosterCell.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 01/02/21.
//

import UIKit

class PosterCell: UITableViewCell {
  @IBOutlet weak var moviePoster: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func updateMovie(data: MovieData) {
    moviePoster.setImg(from: data.value ?? "", quality: .W500)
  }
  
}
