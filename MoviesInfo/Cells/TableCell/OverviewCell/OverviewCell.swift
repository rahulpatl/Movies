//
//  OverviewCell.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 01/02/21.
//

import UIKit

class OverviewCell: UITableViewCell {
  @IBOutlet weak var overviewText: UILabel!
  @IBOutlet weak var overviewView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    overviewView.layer.cornerRadius = 8
    overviewView.layer.borderWidth = 1.5
    overviewView.layer.borderColor = UIColor.lightGray.cgColor
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setUp(data: MovieData) {
    overviewText.text = data.value
  }
}
