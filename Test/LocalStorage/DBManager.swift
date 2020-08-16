import Foundation
import RealmSwift

/// This class performs database operations.
class DBManager {

  private var database:Realm
  static let sharedInstance = DBManager()

  private init() {
    database = try! Realm()
  }

  // Add objects into Realam database
  func addData<T:Object>(objects: [T]) {
     deleteAllFromDatabase()
     try! database.write {
       database.add(objects)
     }
   }

  // Retrieve objects from Realam database
  func retrieveData<T:Object>(
    ofType: T.Type,
    completion: @escaping ([T]?) -> ()
  )  {
    let objects = database.objects(T.self as Object.Type).toArray(ofType : T.self) as [T]
    completion(objects)
  }

  // Delete all objects from Realam database
  func deleteAllFromDatabase()  {
    try! database.write {
      database.deleteAll()
    }
  }

  // Delete single object from Realam database
  func deleteFromDb<T:Object>(object: T)   {
    try! database.write {
      database.delete(object)
    }
  }
}

extension Results {
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for i in 0 ..< count {
      if let result = self[i] as? T {
        array.append(result)
      }
    }
    return array
  }
}
