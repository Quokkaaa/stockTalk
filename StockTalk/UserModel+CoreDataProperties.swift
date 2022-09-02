//
//  UserModel+CoreDataProperties.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/30.
//
//

import Foundation
import CoreData

extension UserModel {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserModel> {
        return NSFetchRequest<UserModel>(entityName: "UserModel")
    }

    @NSManaged public var id: String?
    @NSManaged public var nickName: String?
    @NSManaged public var socialLoginType: String?
    @NSManaged public var isLogin: Bool
    @NSManaged public var createdAt: Date?
    @NSManaged public var postCount: Int64
    @NSManaged public var followerCount: Int64
    @NSManaged public var followingCount: Int64

}

extension UserModel : Identifiable {

}
