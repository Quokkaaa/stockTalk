//
//  NickNameSetViewController.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/09/02.
//

import UIKit
import SnapKit

final class NickNameSetViewController: UIViewController {
  private lazy var viewModel = NickNameSetViewModel(loginType: self.loginType)
  var loginType: SNSLogin
  
  init(loginType: SNSLogin) {
    self.loginType = loginType
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.alignment = .fill
    return stack
  }()
  
  private let textField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "닉네임을 정해보세요"
    return textField
  }()
  
  private lazy var doubleCheckButton: UIButton = {
    let button = UIButton()
    button.setTitle("중복확인", for: .normal)
    button.addTarget(self, action: #selector(checkNickNameIsDouble), for: .touchUpInside)
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  @objc func checkNickNameIsDouble() {
    viewModel.doubleCheckButtonDidTap(textField.text)
    showAlert(viewModel.isDouble)
  }
  
  private func showAlert(_ doubled: Bool) {
    var message = ""
    
    if doubled == true {
      message = "이미 사용자가 존재합니다."
    }
    
    if doubled == false {
      message = "사용 가능합니다."
    }
    
    let alert = UIAlertController(
      title: "✅",
      message: message,
      preferredStyle: .alert)
    
    let willUse = UIAlertAction(title: "사용", style: .cancel) { _ in
      self.viewModel.usingNickNameDidTap(self.textField.text)
    }
    
    let ok = UIAlertAction(title: "확인", style: .default)
    
    alert.addAction(willUse)
    alert.addAction(ok)
    
    present(alert, animated: true)
  }
  
  private func configureUI() {
    view.backgroundColor = .systemBackground
    view.addSubview(stackView)
    
    stackView.addArrangedSubview(textField)
    stackView.addArrangedSubview(doubleCheckButton)
    
    stackView.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
    }
  }
}
