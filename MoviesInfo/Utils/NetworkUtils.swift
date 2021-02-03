//
//  NetworkUtils.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 30/01/21.
//

import Foundation
import Alamofire

class NetworkUtils {
  let headers: HTTPHeaders?
  
  init() {
    let token = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZTU1N2U3Mzg1NzkxYTZhM2FlM2FmMjgwMmIyMTRlZSIsInN1YiI6IjYwMTM2MzdiMGU1OTdiMDA0MDNiMTAxNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.PebUpcu842xWwaVVtKaVvyfhyqq4JCl21GKguyOJccA"
    headers = HTTPHeaders(["Authorization":token])
  }
  
  func getData<T: Decodable>(url: String, object: T.Type, compilation: @escaping (T?) -> Void) {
    let request = AF.request(url, headers: headers)
    request.responseJSON { (data) in
      do {
        if let data = data.data {
          let response = try? JSONDecoder().decode(object, from: data)
          compilation(response)
        } else {
          compilation(nil)
        }
      }
    }
  }
}
