//
//  DAO.swift
//  HeTeC
//
//  Created by damir hodez on 26/12/2019.
//  Copyright © 2019 damir hodez. All rights reserved.
//

import Foundation
import CoreData

class DAO {
    static let shared = DAO()
    let context = CoreDataStack.shared.context
    
    private init () {}

    func lastLoggedUser() -> User?{
        let requset:NSFetchRequest<User> = User.fetchRequest()
        guard let users:[User] = try? context.fetch(requset) else {return nil}
        
        for user in users {
            if user.isLastLogged {
                return user
            }
        }
        return nil
    }
    
    func logInToUser(username: String, password: String) -> User? {
        let requset:NSFetchRequest<User> = User.fetchRequest()
        guard let users:[User] = try? context.fetch(requset) else {return nil}
        
        for user in users {
            if user.username == username {
                if user.password == password {
                    return user
                }
            }
        }
        return nil
    }
    
    func addNewUser(username: String, password: String, name: String) -> User {
        let user = User(context: context)
        user.username = username
        user.password = password
        user.name = name
        user.isLastLogged = true
        CoreDataStack.shared.saveContext()
        return user
    }
    
    func createNewBill() -> Bill {
        let newBill = Bill(context: context)
        return newBill
    }
    
    func changeLastLogged(user: User, lastLogged: Bool) {
        user.isLastLogged = lastLogged
        try? context.save()
    }
    
    func changeName(user: User, newName: String) {
        user.name = newName
        try? context.save()
    }
    
    func changePassword(user: User, newPassword: String) {
        user.password = newPassword
        try? context.save()
    }
    
    func addBill(user: User, newBill: Bill) {
        print("save")
        print(newBill)
        user.bills!.adding(newBill)
        try? context.save()
    }
    
    func deleteBill(user: User, Bill: Bill) {
        user.removeFromBills(Bill)
        try? context.save()
    }
    
    func getAllBills(currentUser: User) -> [Bill] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        guard let users: [User] = try? context.fetch(request) else { return [] }
        for user in users {
            if user.username == currentUser.username {
                if let bills = user.bills!.allObjects as? [Bill] {
                    return bills
                }
            }
        }
        return []
    }
    
    func removeUser(user: User) {
        context.delete(user)
        try? context.save()
    }
    
    func removeAllUsers() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        guard let users: [User] = try? context.fetch(request) else {return}
        for user in users {
            context.delete(user)
        }
    }
    
    func printAllUsersName() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        guard let users: [User] = try? context.fetch(request) else {return}
        for user in users {
            print(user.username!)
        }
    }
    
    func printAllUsersBills() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        guard let users: [User] = try? context.fetch(request) else {return}
        for user in users {
            if let bills = user.bills!.allObjects as? [Bill] {
                for bill in bills {
                    print(bill.type!)
                }
            }
        }
    }
    
    func changeOwnership(user: User, isOwner: Bool) {
        user.isOwner = isOwner
        try? context.save()
    }
    
    func changeMorgageInclude(user: User, includeMorgage: Bool) {
        user.includeMorgage = includeMorgage
        try? context.save()
    }
    
    func changeElectricityInclude(user: User, includeElectricity: Bool) {
        user.includeElectricity = includeElectricity
        try? context.save()
    }
    
    func changeGasInclude(user: User, includeGas: Bool) {
        user.includeGas = includeGas
        try? context.save()
    }
    
    func changeWaterInclude(user: User, includeWater: Bool) {
        user.includeWater = includeWater
        try? context.save()
    }
    
    func changePropertyTaxInclude(user: User, includePropertyTax: Bool) {
        user.includePropertyTax = includePropertyTax
        try? context.save()
    }
    
    func changeHouseKeepInclude(user: User, includeHouseKeep: Bool) {
        user.includeHouseKeep = includeHouseKeep
        try? context.save()
    }
    
    func changeCarOwnership(user: User, isCarOwner: Bool) {
        user.includeCar = isCarOwner
        try? context.save()
    }
    
    func changeCarGas(user: User, includeCarGas: Bool) {
        user.includeCarGas = includeCarGas
        try? context.save()
    }
    
    func changeCarTest(user: User, includeCarTest: Bool) {
        user.includeCarTest = includeCarTest
        try? context.save()
    }
    
    func changeCarReports(user: User, includeCarReports: Bool) {
        user.includeCarReports = includeCarReports
        try? context.save()
    }
    
    
    
}
