import UIKit
import AlamofireImage
import Alamofire

/// This custom class is used for download image from server.
/// We can extend functionality of this class.
class CustomImageView: UIImageView {

  func downloadImageFrom(urlString: String, imageMode: UIView.ContentMode) {
    guard let url = URL(string: urlString) else {
      return
    }
    image = UIImage(named: "placeholder-image")
    AF.request(url).responseImage { response in
      if case .success(let image) = response.result {
        self.image = image
      }
    }
  }
}
