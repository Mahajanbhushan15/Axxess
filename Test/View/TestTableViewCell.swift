import UIKit

/// Configure and bind data to tableView cell.

// MARK: - Text cell
class TestTableViewCell: UITableViewCell {

  lazy var dateLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16,weight: .bold)
    lbl.textAlignment = .right
    lbl.numberOfLines = 0
    return lbl
  }()

  lazy var descriptionLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16)
    lbl.textAlignment = .left
    lbl.numberOfLines = 0
    return lbl
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(dateLabel)
    contentView.addSubview(descriptionLabel)

    dateLabel.snp.makeConstraints {
      $0.left.equalToSuperview().offset(10)
      $0.right.equalToSuperview().offset(-10)
      $0.top.equalToSuperview().offset(10)
    }

    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.snp.makeConstraints {
      $0.left.equalToSuperview().offset(10)
      $0.right.equalToSuperview().offset(-10)
      $0.top.equalTo(dateLabel).offset(20)
      $0.bottom.equalToSuperview().offset(-10)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // Bind data to tableView cell.
  func configureCell(testModel: Test?) {
    selectionStyle = .none
    dateLabel.text = testModel?.date
    descriptionLabel.text = testModel?.data
  }
}

// MARK: - Image cell
class TestImageTableViewCell: UITableViewCell {

  lazy var dateLabel : UILabel = {
    let lbl = UILabel()
    lbl.textColor = .black
    lbl.font = UIFont.systemFont(ofSize: 16,weight: .bold)
    lbl.textAlignment = .right
    lbl.numberOfLines = 0
    return lbl
  }()

  lazy var customImageView : CustomImageView = {
    let imageView = CustomImageView()
    imageView.image = UIImage(named: "placeholder-image")
    return imageView
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    contentView.addSubview(dateLabel)
    contentView.addSubview(customImageView)

    dateLabel.snp.makeConstraints {
      $0.left.equalToSuperview().offset(10)
      $0.right.equalToSuperview().offset(-10)
      $0.top.equalToSuperview().offset(10)
    }

    customImageView.snp.makeConstraints {
      $0.left.equalToSuperview().offset(10)
      $0.right.equalToSuperview().offset(-10)
      $0.top.equalTo(dateLabel).offset(20)
      $0.bottom.equalToSuperview().offset(-10)
      $0.height.equalTo(150)
    }
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // Bind data to tableView cell.
  func configureCell(testModel: Test?) {
    dateLabel.text = testModel?.date
    guard let imageUrl = testModel?.data,
      !imageUrl.isEmpty
    else {
      return
    }
    customImageView.downloadImageFrom(
      urlString: imageUrl,
      imageMode: .scaleToFill
    )
  }
}
