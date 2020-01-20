//
//  SSCoreDataManager.swift
//  CoreDataTest
//
//  Created by nie yu on 2020/1/14.
//  Copyright © 2020 nie yu. All rights reserved.
//

import UIKit
import CoreData

//public class SSCoreDataManager: NSObject {
//
//    static let shareInstance: SSCoreDataManager = SSCoreDataManager()
//    
//    public var databaseName: String = "" {
//        didSet {
//            createSQL()
//        }
//    }
//    
//    public var context: NSManagedObjectContext
//    
//    private override init() {
//        self.context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
//        super.init()
//    }
//    
//    private func createSQL() {
//        
//        guard databaseName != "" else {
//            ssprint("没有设置数据库名字")
//            return
//        }
//        
//        guard let databasePath = Bundle.main.path(forResource: databaseName, ofType: "momd") else {
//            ssprint("数据库文件不存在")
//            return
//        }
//        
//        let databaseURL = URL.init(fileURLWithPath: databasePath)
//        
//        //创建模型
//        guard let managerModel = NSManagedObjectModel.init(contentsOf: databaseURL) else {
//            ssprint("NSManagedObjectModel 创建失败")
//            return
//        }
//        
//        let documentPath: String = NSSearchPathForDirectoriesInDomains(.documentDirectory,
//                                                                  .userDomainMask,
//                                                                  true).last!
//        let sqlPath = documentPath + "/\(databaseName).sql"
//        let sqlURL: URL = URL.init(fileURLWithPath: sqlPath)
//        let storeCoordinator = NSPersistentStoreCoordinator.init(managedObjectModel: managerModel)
//        do {
//            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
//                                                    configurationName: nil,
//                                                    at: sqlURL,
//                                                    options: nil)
//        } catch {
//            ssprint("数据库持久化失败")
//        }
//        context.persistentStoreCoordinator = storeCoordinator
//    }
//    
//    @discardableResult
//    public func insert<T: SSCoreDataFetchProtocol>(model: T) -> [T]? {
//        let insertRequest = T.fetchRequest()
//        do {
//            let result = try context.fetch(insertRequest)
//            try context.save()
//            return result as? [T]
//        } catch {
//            print("insert fetchRequest error\(error.localizedDescription)")
//        }
//        return nil
//    }
//    
//    public func delete<T: SSCoreDataFetchProtocol>(model: T) {
//        let deleteRequest = T.fetchRequest()
//        deleteRequest.predicate = NSPredicate.init(format: "name BEGINSWITH %@", model.name!)
//        do {
//            let result = try context.fetch(deleteRequest) as! [T]
//            result.forEach { element in
//                context.delete(element as! NSManagedObject)
//            }
//            try context.save()
//        } catch {
//            ssprint("delete failure")
//        }
//    }
//    
//    public func query<T: SSCoreDataFetchProtocol>(model: T.Type) -> [T]? {
//        let request = T.fetchRequest()
//        do {
//            let result = try context.fetch(request)
//            return result as? [T]
//        } catch {
//            ssprint("query failure")
//        }
//        
//        return nil
//    }
//    
//}
//
//public func ssprint<T>(_ message: T,
//                       _ file: String = #file,
//                       _ function: String = #function,
//                       _ line: Int = #line) {
//    #if DEBUG
//    let datestr = Date().description
//    let fileName = (file as NSString).lastPathComponent
//    let consoleStr = "$$$ \(datestr) $$ \(fileName.components(separatedBy: ".").first!) 第 \(line) 行 | 方法: \(function) | LOG: \(message)\n"
//    print(consoleStr)
//    #endif
//}
