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
  private let loginView = LoginView(frame: .zero)
  
  override func loadView() {
    super.loadView()
    view = loginView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTargets()
    setBindings()
  }
  
  private func setTargets() {
    loginView.appleLoginButton.addTarget(
      self,
      action: #selector(appleLoginButtonDidTap),
      for: .touchUpInside)
    
    loginView.appleLoginButton.addTarget(
      self,
      action: #selector(kakaoLoginButtonDidTap),
      for: .touchUpInside)
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
      .assign(to: \.text, on: loginView.titleLabel)
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
