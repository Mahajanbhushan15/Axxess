import Foundation
import RealmSwift

/// Data model which is used for:
/// - Encode & Decode the response.
/// - Perform operation on realm database.

class Test: Object, Codable {
   @objc dynamic var id: String
   @objc dynamic var type: String
   @objc dynamic var date: String?
   @objc dynamic var data: String?
}

