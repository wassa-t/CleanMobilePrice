import Foundation

enum Result<T> {
  case success(T)
  case failure(Error)
}

struct Mobile: Codable {
  
  var name: String?
  var price: Float?
  var thumbImage: String?
  var id: Int?
  var brand: String?
  var rating: Float?
  var description: String?
  
  private enum CodingKeys: String, CodingKey {
    case name, price, id, brand, rating, description
    case thumbImage = "thumbImageURL"
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
