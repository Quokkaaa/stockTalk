//
//  NickNameSetViewModel.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/09/02.
//

import Foundation

final class NickNameSetViewModel {
  var user: User?
  let loginType: SNSLogin
  let localDB: CoreDataService
  
  init(loginType: SNSLogin ,localDB: CoreDataService = .shared) {
    self.loginType = loginType
    self.localDB = localDB
  }
  
  // MARK: - Input
  func doubleCheckButtonDidTap(_ nickName: String?) {
    isDouble = isNickNameDouble(nickName)
  }
  
  func usingNickNameDidTap(_ nickName: String?) {
    guard let nickName = nickName,
          var user = user else {
      return
    }
    
    user = User(
      id: UUID().uuidString,
      nickName: nickName,
      socialLoginType: loginType,
      createdAt: Date.now,
      isLogin: true,
      postCount: 0,
      followerCount: 0,
      followingCount: 0)
    
    localDB.create(user)
  }
  
  private func isNickNameDouble(_ nickName: String?) -> Bool {
    guard let nickName = nickName else {
      return false
    }
    
    if localDB.findUser(from: nickName) == nil {
      return false
    } else {
      return true
    }
  }
  
  // MARK: - Output
  var isDouble: Bool = true
}
