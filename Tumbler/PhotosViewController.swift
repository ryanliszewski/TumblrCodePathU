//
//  PhotosViewController.swift
//  Tumbler
//
//  Created by Ryan Liszewski on 11/11/17.
//  Copyright © 2017 ImThere. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {

  var posts: [[String: Any]] = []
  @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
      let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
      session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
      let task = session.dataTask(with: url) { (data, response, error) in
        if let error = error {
          print(error.localizedDescription)
        } else if let data = data,
          let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
          print(dataDictionary)
          
          let responseDictionary = dataDictionary["response"] as! [String: Any]
          self.posts = responseDictionary["posts"] as! [[String: Any]]
          
          print(self.posts)
        }
      }
      task.resume()
    }
}

extension PhotosViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return posts.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
    let post = posts[indexPath.row]
    let photos = ["photos"] as? [String]
    return cell
  }
}
