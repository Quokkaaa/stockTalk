//
//  LoginViewController.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/23.

import UIKit
import SnapKit
import Combine
import AuthenticationServices

final class LoginViewController: UIViewController {
  private let loginViewModel = LoginViewModel()
  private var subscriptions = Set<AnyCancellable>()
  
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
  
  private let titleLabel: UILabel = {
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
  
  private lazy var kakaoButton = { (action: Selector) -> UIButton in
    let button = UIButton()
    button.setImage(UIImage(named: "kakao_login_medium_wide"), for: .normal)
    button.addTarget(
      self, action: action, for: .touchUpInside)
    return button
  }
  
  private lazy var appleLoginButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .black
    button.setTitle(
        "                       Apple 로그인                        ",
        for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.setImage(UIImage(named: "apple_logo_medium"), for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
    button.layer.cornerRadius = 5
    button.addTarget(
      self,
      action: #selector(appleLoginButtonDidTap),
      for: .touchUpInside)
    return button
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureUI()
    setBindings()
  }
  
  private func configureUI() {
    view.addSubview(stackView)
    
    let kakaoLoginButton = kakaoButton(#selector(kakaoLoginButtonDidTap))
    
    appleLoginButton.addTarget(self, action: #selector(appleLoginButtonDidTap), for: .touchUpInside)
    
    titleStackView.addArrangedSubview(titleLabel)
    titleStackView.addArrangedSubview(subtitleLabel)
    buttonStackView.addArrangedSubview(kakaoLoginButton)
    buttonStackView.addArrangedSubview(appleLoginButton)
    stackView.addArrangedSubview(titleStackView)
    stackView.addArrangedSubview(buttonStackView)
    
    stackView.snp.makeConstraints { make in
      make.center.equalTo(view)
    }
  }
  
  @objc private func kakaoLoginButtonDidTap() {
    loginViewModel.kakaoLoginButtonDidTap()
  }
  
  @objc private func appleLoginButtonDidTap() {
    loginViewModel.appleLoginButtonDidTap()
  }
}

private extension LoginViewController {
  func setBindings() {
    // MARK: - 첫번째방법 (구독)
//    self.kakaoLoginViewModel.$isLoggedIn.sink { [weak self] isLoggedIn in
//      guard let self = self else { return }
//      self.kakaoLoginStatusLabel.text = isLoggedIn ? "로그인 상태" : "로그아웃 상태"
//    }
//    .store(in: &subscriptions)
    
    // MARK: - 두번째방법 AnyPublisher로 값을 받아서 Label에 꽂아준다.
    self.loginViewModel.loginService?.loginStatusInfo
      .receive(on: DispatchQueue.main)
      .assign(to: \.text, on: titleLabel)
      .store(in: &subscriptions)
  }
}

// MARK: - Apple Login Method extension
extension LoginViewController: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    print("Failed!")
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    switch authorization.credential {
    case let credentials as ASAuthorizationAppleIDCredential:
      let email = credentials.email
      let lastName = credentials.fullName?.familyName
      let firstName = credentials.fullName
      break
    default:
      break
    }
  }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
  func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    return view.window ?? UIWindow()
  }
}
