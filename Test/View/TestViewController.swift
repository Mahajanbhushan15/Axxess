import UIKit
import SnapKit
import Reachability

/// Show list of items which is sort and display items based on their “type”
class TestViewController: UIViewController {

  lazy var tableView = UITableView()

  lazy var viewModel : TestViewModel = {
    return TestViewModel()
  }()

  var groupedItems: [[String : [Test]]] = []
  var sections: [String] = []

  // MARK: - UIViewController life cycle.

  override func viewDidLoad() {
    super.viewDidLoad()
    title = UIConstants.listScreenTitle
    // Add tableView and set constraints to it.
    view.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
      $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
    }

    // Register tableView cells
    tableView.register(
      TestImageTableViewCell.self,
      forCellReuseIdentifier: UIConstants.imageCellIdentifier
    )
    tableView.register(
      TestTableViewCell.self,
      forCellReuseIdentifier: UIConstants.textCellIdentifier
    )
    tableView.dataSource = self
    tableView.delegate = self

    // Fetch data from server.
    viewModel.responseDelegate = self
    viewModel.fetchData()
  }
}

// MARK: - API Response delegate methods.

extension TestViewController: APIResponseProtocol {

  /// It handles sucess of API response.
  func didReceivedResponse<T>(response: T?) {
    guard let response = response as? [Test],
      response.count > 0
    else {
      return
    }
    // Creates a section array, Is use title for header section.
    response.forEach {
      if !sections.contains($0.type) {
        sections += [$0.type]
      }
    }
    // Sort items based on their “type”
    groupedItems = Array(arrayLiteral: Dictionary(grouping: response, by: { $0.type }))
    groupedItems.first?.sorted(by: { $0.key < $1.key })
    tableView.reloadData()
  }

  /// It handles failure of API response.
  func didReceivedFailure(error: String) {
    let alert = UIAlertController(
      title: UIConstants.failureAlertTitle,
      message: error, preferredStyle: .alert
    )
    alert.addAction(
      UIAlertAction(title: UIConstants.okButtonTitle,
                    style: .default, handler: nil)
    )
    self.present(alert, animated: true)
  }
}

// MARK: - TableView delegate and datasource methods.

extension TestViewController: UITableViewDataSource, UITableViewDelegate {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return groupedItems.first?[sections[section]]?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    var cell: UITableViewCell?

    guard let data = groupedItems.first?[sections[indexPath.section]],
      !data.isEmpty
    else {
        return UITableViewCell()
    }

    if data[indexPath.row].type == UIConstants.TypeEnum.image.rawValue {

      guard let imageCell = tableView.dequeueReusableCell(
        withIdentifier: UIConstants.imageCellIdentifier,
        for: indexPath
        ) as? TestImageTableViewCell
      else {
          return UITableViewCell()
      }
      imageCell.configureCell(testModel: data[indexPath.row])
      cell = imageCell
    } else if data[indexPath.row].type == UIConstants.TypeEnum.text.rawValue
      || data[indexPath.row].type == UIConstants.TypeEnum.other.rawValue {

      guard let textCell = tableView.dequeueReusableCell(
        withIdentifier: UIConstants.textCellIdentifier,
        for: indexPath
        ) as? TestTableViewCell
      else {
          return UITableViewCell()
      }
      textCell.configureCell(testModel: data[indexPath.row])
      cell = textCell
    }
    return cell ?? UITableViewCell()
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return sections[section]
 }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    guard let data = groupedItems.first?[sections[indexPath.section]],
      !data.isEmpty
    else {
        return
    }
    let selectedItem = data[indexPath.row]
    performSegue(withIdentifier: UIConstants.segueIdentifier, sender: selectedItem)
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailsViewController = segue.destination as? TestDetailsViewController,
      let detailToSend = sender as? Test {
      detailsViewController.testModel = detailToSend
    }
  }
}
