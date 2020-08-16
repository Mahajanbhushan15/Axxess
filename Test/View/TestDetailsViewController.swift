//
//  TestDetailsViewController.swift
//  Test
//
//  Created by Bhushan Mahajan on 15/08/20.
//  Copyright © 2020 Bhushan Mahajan. All rights reserved.
//

import UIKit
import SnapKit

class TestDetailsViewController: UIViewController {

  var testModel: Test?

  lazy var scrollView : UIScrollView = {
    let scrollView = UIScrollView()
    return scrollView
  }()

  lazy var scrollContentView : UIView = {
    let scrollContentView = UIView()
    scrollContentView.backgroundColor = .white
    return scrollContentView
  }()

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

  private let customImageView : CustomImageView = {
    let imageView = CustomImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = UIConstants.detailScreenTitle
    // Add scrollView.
    view.addSubview(scrollView)
    scrollView.snp.makeConstraints {
      $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      $0.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
      $0.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
      $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
      $0.centerX.equalToSuperview()
      $0.centerY.equalToSuperview()
    }

    // Add content view in scrollView.
    scrollView.addSubview(scrollContentView)
    scrollContentView.snp.makeConstraints {
      $0.top.bottom.equalTo(scrollView)
      $0.left.right.equalTo(self.view)
      $0.width.equalTo(scrollView)
      $0.height.greaterThanOrEqualTo(scrollView)
    }

    // Add date label in scrollContentView.
    scrollContentView.addSubview(dateLabel)
    dateLabel.snp.makeConstraints {
      $0.left.equalTo(scrollContentView.snp.left).offset(20)
      $0.right.equalTo(scrollContentView.snp.right).offset(-20)
      $0.top.equalTo(scrollContentView.snp.top).offset(20)
    }
    dateLabel.text = testModel?.date

    if testModel?.type == UIConstants.TypeEnum.text.rawValue
    || testModel?.type == UIConstants.TypeEnum.other.rawValue {

      // Add description label in scrollContentView.
      scrollContentView.addSubview(descriptionLabel)
      descriptionLabel.text = testModel?.data
      descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
      descriptionLabel.snp.makeConstraints {
        $0.left.equalTo(scrollContentView.snp.left).offset(20)
        $0.right.equalTo(scrollContentView.snp.right).offset(-20)
        $0.top.equalTo(scrollContentView.snp.top).offset(20)
        $0.bottom.equalTo(scrollContentView.snp.bottom)
      }
    } else {
       // Add imageView in scrollContentView.
      scrollContentView.addSubview(customImageView)
      customImageView.snp.makeConstraints {
        $0.left.equalTo(scrollContentView.snp.left).offset(20)
        $0.right.equalTo(scrollContentView.snp.right).offset(-20)
        $0.top.equalTo(scrollContentView.snp.top).offset(20)
        $0.bottom.equalTo(scrollContentView.snp.bottom)
      }
      guard let imageUrl = testModel?.data,
        !imageUrl.isEmpty
      else {
        return
      }
      customImageView.downloadImageFrom(
        urlString: imageUrl,
        imageMode: .scaleAspectFit
      )
    }
  }
}
