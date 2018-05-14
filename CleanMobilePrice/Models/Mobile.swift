import Foundation
import ObjectMapper

enum Result<T> {
  case success(T)
  case failure(Error)
}

//
// The entity or business object
//
struct Mobile: Mappable {
  
  var name: String?
  var price: Float?
  var thumbImage: String?
  var id: Int?
  var brand: String?
  var rating: Float?
  var description: String?
  
  internal init(name: String, price: Float, thumbImageURL: String, id: Int, brand: String, rating: Float, description: String) {
    self.name = name
    self.price = price
    self.thumbImage = thumbImageURL
    self.id = id
    self.brand = brand
    self.rating = rating
    self.description = description
  }
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    name <- map["name"]
    price <- map["price"]
    thumbImage <- map["thumbImageURL"]
    id <- map["id"]
    brand <- map["brand"]
    rating <- map["rating"]
    description <- map["description"]
  }
  
  var thumbImageURL: URL? {
    if let thumbImage = thumbImage {
      return URL(string: thumbImage)
    } else {
      return nil
    }
  }
  
  var priceString: String {
    return "Price: \(price ?? 0)"
  }
  
  var ratingString: String {
    return "Rating: \(rating ?? 0)"
  }
  
  struct Displayed {
    var name: String?
    var description: String?
    var price: String?
    var rating: String?
    var thumbImageURL: URL?
    var isFavorite: Bool
  }
}
