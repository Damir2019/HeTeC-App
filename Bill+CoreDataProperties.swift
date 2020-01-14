//
//  Bill+CoreDataProperties.swift
//  HeTeC
//
//  Created by damir hodez on 30/12/2019.
//  Copyright © 2019 damir hodez. All rights reserved.
//
//

import Foundation
import CoreData


extension Bill {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bill> {
        return NSFetchRequest<Bill>(entityName: "Bill")
    }

    @NSManaged public var clientNumber: Int16
    @NSManaged public var startDate: Date?
    @NSManaged public var recipeNumber: Int16
    @NSManaged public var endDate: Date?
    @NSManaged public var type: String?
    @NSManaged public var value: Float
    @NSManaged public var user: User?

}
