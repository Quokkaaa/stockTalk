//
//  CoreDataService.swift
//  StockTalk
//
//  Created by LIMGAUI on 2022/08/30.
//

import Foundation
import Combine
import CoreData

final class CoreDataService: StorageType {
  static let shared = CoreDataService()
  private var users = CurrentValueSubject<[User], Never>([])
  
  private init() {}
  
  // MARK: - Core Data stack
  
  private lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "StockTalk")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  private var viewContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: - Core Data Saving support
  
  func saveContext() {
    if viewContext.hasChanges {
      do {
        try viewContext.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func create<T: User>(_ item: T) {
    let userEntity = NSEntityDescription.entity(forEntityName: "UserModel", in: viewContext)
    
    if let userEntity = userEntity {
      // NSManagerObject를 만든다.
      let user = NSManagedObject(entity: userEntity, insertInto: viewContext)
      
      user.setValue(item.id, forKey: "id")
      user.setValue(item.nickName, forKey: "nickName")
      user.setValue(item.socialLoginType, forKey: "socialLoginType")
      user.setValue(item.isLogin, forKey: "isLogin")
      user.setValue(item.createdAt, forKey: "createdAt")
      user.setValue(item.postCount, forKey: "postCount")
      user.setValue(item.followerCount, forKey: "followerCount")
      user.setValue(item.followingCount, forKey: "followingCount")
      
      self.saveContext()
      _ = read()
    }
  }
  
  func read() -> AnyPublisher<[User], Never> {
    do {
      let userModels = try viewContext.fetch(UserModel.fetchRequest())
      let users = convertUsers(from: userModels)
      self.users.send(users)
      
      return self.users.eraseToAnyPublisher()
    } catch {
      fatalError()
    }
  }
  
  func update<T: User>(_ item: T) {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "UserModel")
    fetchRequest.predicate = NSPredicate(format: "id = %@", item.id)
    
    do {
      let object = try viewContext.fetch(fetchRequest).first as? NSManagedObject
      object?.setValue(item.isLogin, forKey: "isLogin")
      object?.setValue(item.followerCount, forKey: "followerCount")
      object?.setValue(item.followingCount, forKey: "followingCount")
      object?.setValue(item.postCount, forKey: "postCount")
      saveContext()
      _ = read()
    } catch {
      fatalError()
    }
  }
  
  func delete<T: UserModel>(_ item: T) {
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "UserModel")
    guard let id = item.id else { return }
    fetchRequest.predicate = NSPredicate(format: "id = %@", id)
    
    do {
      guard let object = try viewContext.fetch(fetchRequest).first as? NSManagedObject else {
        return
      }
      viewContext.delete(object)
      saveContext()
      _ = read()
    } catch {
      fatalError()
    }
  }
  
  func findUser(from nickName: String) -> User? {
    return users.value.first { user in
      user.nickName == nickName
    }
  }
  
  private func convertUsers(from userModels: [UserModel]) -> [User] {
    userModels.compactMap {
      guard let id = $0.id,
            let nickName = $0.nickName,
            let wrappedSocialLoginType = $0.socialLoginType,
            let socialLoginType = SNSLogin(rawValue: wrappedSocialLoginType),
            let createdAt = $0.createdAt else {
        return nil
      }
      
      return User(
        id: id,
        nickName: nickName,
        socialLoginType: socialLoginType,
        createdAt: createdAt,
        isLogin: $0.isLogin,
        postCount: Int($0.postCount),
        followerCount: Int($0.followerCount),
        followingCount: Int($0.followingCount))
    }
  }
}
