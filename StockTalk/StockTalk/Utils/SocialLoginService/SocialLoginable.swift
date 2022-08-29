//
//  SocialLoginable.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/24.
//

import Foundation
import Combine

protocol SocialLoginable {
  var isLoggedIn: Bool { get set }
  var loginStatusInfo: AnyPublisher<String?, Never> { get set }
  
  func login()
  func logout()
}
