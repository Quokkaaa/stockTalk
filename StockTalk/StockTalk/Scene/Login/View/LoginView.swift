//
//  LoginView.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/29.
//

import UIKit
import SnapKit

final class LoginView: UIView {
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 150
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    return stackView
  }()
  
  private let titleStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 5
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    return stackView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "StockTalk"
    label.textAlignment = .center
    label.font = UIFont.boldSystemFont(ofSize: 50)
    return label
  }()
  
  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.text = "해당 서비스 이용을 위해 로그인 해주세요."
    label.textAlignment = .center
    label.textColor = .systemGray3
    return label
  }()
  
  private let buttonStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 20
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    return stackView
  }()
  
  lazy var kakaoLoginButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "kakao_login_medium_wide"), for: .normal)
    return button
  }()
  
  lazy var appleLoginButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .black
    button.setTitle(
        "                       Apple 로그인                        ",
        for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.setImage(UIImage(named: "apple_logo_medium"), for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    button.layer.cornerRadius = 5
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemBackground
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureUI() {
    addSubview(stackView)
    
    titleStackView.addArrangedSubview(titleLabel)
    titleStackView.addArrangedSubview(subtitleLabel)
    buttonStackView.addArrangedSubview(kakaoLoginButton)
    buttonStackView.addArrangedSubview(appleLoginButton)
    stackView.addArrangedSubview(titleStackView)
    stackView.addArrangedSubview(buttonStackView)
    
    stackView.snp.makeConstraints { make in
      make.center.equalTo(self)
    }
  }
}
