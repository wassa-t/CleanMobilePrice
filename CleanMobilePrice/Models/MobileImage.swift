import Foundation
import ObjectMapper

//
// The entity or business object
//
struct MobileImage: Mappable {
    
    var mobileID: Int?
    var imagePath: String?
    var id: Int?
    
    internal init(mobileID: Int, imageURL: String, id: Int) {
        self.id = id
        self.imagePath = imageURL
        self.mobileID = mobileID
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        mobileID <- map["mobile_id"]
        imagePath <- map["url"]
        id <- map["id"]
    }
  
  var imageURL: URL? {
    if let imagePath = imagePath {
      var path = imagePath
      if !imagePath.hasPrefix("http://") && !imagePath.hasPrefix("https://") {
        path = "http://\(imagePath)"
      }
      return URL(string: path)
    } else {
      return nil
    }
  }
}
