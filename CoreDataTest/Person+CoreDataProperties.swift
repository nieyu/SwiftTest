//
//  Person+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by nie yu on 2020/1/10.
//  Copyright © 2020 nie yu. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var age: Int16
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var sex: Bool
    @NSManaged public var feets: Int16

}

//extension Person: SSCoreDataFetchProtocol {}
//
//public protocol SSCoreDataFetchProtocol: NSFetchRequestResult {
//    var name: String? { get }
//    static func fetchRequest() -> NSFetchRequest<NSFetchRequestResult>
//}
