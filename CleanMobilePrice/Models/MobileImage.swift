import Foundation

struct MobileImage: Codable {
  
  var mobileID: Int?
  var imagePath: String?
  var id: Int?
  
  private enum CodingKeys: String, CodingKey {
    case mobileID = "mobile_id"
    case imagePath = "url"
    case id
  }
  
  var imageURL: URL? {
    if var imagePath = imagePath {
      if !imagePath.hasPrefix("http://") && !imagePath.hasPrefix("https://") {
        imagePath = "http://\(imagePath)"
      }
      return URL(string: imagePath)
    } else {
      return nil
    }
  }
}
