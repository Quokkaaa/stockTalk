//
//  User.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/23.
//

import Foundation
import Combine

class User {
  let id: String
  let nickName: String
  let socialLoginType: SNSLogin
  let createdAt: Date
  var isLogin: Bool
  var postCount: Int
  var followerCount: Int
  var followingCount: Int
  
  init(id: String,
       nickName: String,
       socialLoginType: SNSLogin,
       createdAt: Date,
       isLogin: Bool,
       postCount: Int,
       followerCount: Int,
       followingCount: Int) {
    self.id = id
    self.nickName = nickName
    self.socialLoginType = socialLoginType
    self.createdAt = createdAt
    self.isLogin = isLogin
    self.postCount = postCount
    self.followerCount = followerCount
    self.followingCount = followingCount
  }
}
