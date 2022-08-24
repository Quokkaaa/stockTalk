//
//  ViewController.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/23.

import UIKit
import SnapKit
import Combine

final class ViewController: UIViewController {
  private let kakaoLoginViewModel = KakaoAuthViewModel()
  private var subscriptions = Set<AnyCancellable>()
  
  private let kakaoLoginStatusLabel: UILabel = {
    let label = UILabel()
    label.text = "로그인 상태"
    return label
  }()
  
  private lazy var kakaoButton = { (_ title: String, _ action: Selector) -> UIButton in
    let button = UIButton()
    button.setTitle(title, for: .normal)
    button.configuration = .filled()
    button.addTarget(
      self, action: action, for: .touchUpInside)
    return button
  }
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.spacing = 8
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .fill
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureUI()
    setBindings()
  }
  
  private func configureUI() {
    view.addSubview(stackView)
    
    let kakaoLoginButton = kakaoButton("카카오 로그인", #selector(kakaoLoginButtonDidTap))
    let kakaoLogoutButton = kakaoButton("카카오 로그아웃", #selector(kakaoLogoutButtonDidTap))
    
    stackView.addArrangedSubview(kakaoLoginStatusLabel)
    stackView.addArrangedSubview(kakaoLoginButton)
    stackView.addArrangedSubview(kakaoLogoutButton)
    
    kakaoLoginStatusLabel.snp.makeConstraints { make in
      make.height.greaterThanOrEqualTo(70)
    }
    
    stackView.snp.makeConstraints { make in
      make.center.equalTo(view)
    }
  }
  
  @objc private func kakaoLoginButtonDidTap() {
    print("\(#function)")
    kakaoLoginViewModel.KakaoLogin()
  }
  
  @objc private func kakaoLogoutButtonDidTap() {
    print("\(#function)")
    kakaoLoginViewModel.kakaoLogout()
  }
}

private extension ViewController {
  func setBindings() {
    // MARK: - 첫번째방법 (구독)
//    self.kakaoLoginViewModel.$isLoggedIn.sink { [weak self] isLoggedIn in
//      guard let self = self else { return }
//      self.kakaoLoginStatusLabel.text = isLoggedIn ? "로그인 상태" : "로그아웃 상태"
//    }
//    .store(in: &subscriptions)
    
    // MARK: - 두번째방법 AnyPublisher로 값을 받아서 Label에 꽂아준다.
    self.kakaoLoginViewModel.loginStatusInfo
      .receive(on: DispatchQueue.main)
      .assign(to: \.text, on: kakaoLoginStatusLabel)
      .store(in: &subscriptions)
  }
}
