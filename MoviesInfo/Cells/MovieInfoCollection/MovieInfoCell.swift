//
//  MovieInfoCell.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 31/01/21.
//

import UIKit
import Alamofire

enum ImageQuality: String {
  case W500 = "w500"
  case Original = "original"
}

let imagesCache = NSCache<NSString, AnyObject>()

class MovieInfoCell: UICollectionViewCell {
  @IBOutlet weak var childView: UIView!
  @IBOutlet weak var movieName: UILabel!
  @IBOutlet weak var moviePoster: UIImageView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    prepareUI()
  }
  
  private func prepareUI() {
    childView.layer.cornerRadius = 8
  }
  
  func updateMovie(of data: MoviesList) {
    moviePoster.image = nil
    movieName.text = data.title
    moviePoster.setImg(from: data.posterPath ?? "", quality: .W500)
  }
}

extension UIImageView {
  func setImg(from url: String, quality: ImageQuality) {
    let urlString = "https://image.tmdb.org/t/p/"+quality.rawValue+url
    
    if let _image = imagesCache.object(forKey: NSString(string: url)) as? UIImage {
      image = _image
      return
    }
    
    AF.request(urlString, headers: NetworkUtils().headers).validate().responseData { [weak self] (respone) in
      guard let self = self else {return}
      if respone.error == nil {
        if let _data = respone.data, let _image = UIImage(data: _data) {
          if urlString == url {
            self.image = _image
          }
          
          // Saves the iamge in the image cache.
          imagesCache.setObject(_image, forKey: NSString(string: url))
        }
      } else {
        self.image = UIImage(named: "Error")
      }
    }
  }
}
