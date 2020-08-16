import Foundation

public enum UIConstants {

  public enum TypeEnum: String {
    case image = "image"
    case other = "other"
    case text = "text"
  }

  static let textCellIdentifier = "textCell"
  static let imageCellIdentifier = "imageCell"
  static let failureAlertTitle = "Failed"
  static let okButtonTitle = "Ok"
  static let segueIdentifier = "detailSegue"
  static let listScreenTitle = "List"
  static let detailScreenTitle = "Details"
}
