//
//  User+CoreDataProperties.swift
//  HeTeC
//
//  Created by damir hodez on 06/01/2020.
//  Copyright © 2020 damir hodez. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var isLastLogged: Bool
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var isOwner: Bool
    @NSManaged public var includeMorgage: Bool
    @NSManaged public var includeElectricity: Bool
    @NSManaged public var includeWater: Bool
    @NSManaged public var includeGas: Bool
    @NSManaged public var includePropertyTax: Bool
    @NSManaged public var includeHouseKeep: Bool
    @NSManaged public var includeCar: Bool
    @NSManaged public var includeCarGas: Bool
    @NSManaged public var includeCarTest: Bool
    @NSManaged public var includeCarReports: Bool
    @NSManaged public var bills: NSSet?

}

// MARK: Generated accessors for bills
extension User {

    @objc(addBillsObject:)
    @NSManaged public func addToBills(_ value: Bill)

    @objc(removeBillsObject:)
    @NSManaged public func removeFromBills(_ value: Bill)

    @objc(addBills:)
    @NSManaged public func addToBills(_ values: NSSet)

    @objc(removeBills:)
    @NSManaged public func removeFromBills(_ values: NSSet)

}
