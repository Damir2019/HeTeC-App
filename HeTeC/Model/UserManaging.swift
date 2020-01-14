//
//  UserManaging.swift
//  HeTeC
//
//  Created by damir hodez on 26/12/2019.
//  Copyright © 2019 damir hodez. All rights reserved.
//

import UIKit

class UserManaging {
    static var shared = UserManaging()
    var user: User?
    var elementBills: [String] = []
    var generalBills: [String] = []
    var carBills: [String] = []
    var typeOfBills: [String] = []
    private let dao: DAO = DAO.shared
    
    private init() {}
    
    func lastLoggedUser() -> User? {
        self.user = dao.lastLoggedUser()
        return self.user
    }
    
    func addNewUser(username: String, password: String, name: String) {
        self.user = dao.addNewUser(username: username, password: password, name: name)
    }
    
    func loginToUser(username: String, password: String) -> User? {
        self.user = dao.logInToUser(username: username, password: password)
        return self.user
    }
    
    func createNewBill() -> Bill {
        let newBill = dao.createNewBill()
        return newBill
    }
    
    func addBill(user: User, newBill: Bill) {
        dao.addBill(user: user, newBill: newBill)
    }
    
    func changeName(user: User, newName: String) {
        dao.changeName(user: user, newName: newName)
    }
    
    func changePassword(user: User, newPassword: String) {
        dao.changePassword(user: user, newPassword: newPassword)
    }
    
    func checkForInclude(user: User) {
        changeMorgageInclude(user: user, includeMorgage: user.includeMorgage)
        changeElectricityInclude(user: user, includeElectricity: user.includeElectricity)
        changeGasInclude(user: user, includeGas: user.includeGas)
        changeWaterInclude(user: user, includeWater: user.includeWater)
        changePropertyTaxInclude(user: user, includePropertyTax: user.includePropertyTax)
        changeHouseKeepInclude(user: user, includeHouseKeep: user.includeHouseKeep)
        changeCarOwnership(user: user, isCarOwner: user.includeCar)
        changeCarGas(user: user, includeCarGas: user.includeCarGas)
        changeCarTest(user: user, includeCarTest: user.includeCarTest)
        changeCarReports(user: user, includeCarReports: user.includeCarReports)
        typeOfBills = typeOfBillsSort(array: typeOfBills)
        elementBills = elementSort(array: elementBills)
        generalBills = generalSort(array: generalBills)
        carBills = carSort(array: carBills)
        print("\(elementBills) \n \(generalBills) \n \(carBills) \n \(typeOfBills)")
    }
    
    func changeOwnership(user: User, isOwner: Bool) {
        checkForGeneralBills()
        dao.changeOwnership(user: user, isOwner: isOwner)
        if isOwner {
            if generalBills.contains("Rent") {
                generalBills = removeElementInArray(dataArray: generalBills, keyWord: "Rent")
            }
        } else {
            if generalBills.contains("Morgage") {
                generalBills = removeElementInArray(dataArray: generalBills, keyWord: "Morgage")
            }
            generalBills.append("Rent")
        }
    }
    
    func changeMorgageInclude(user: User, includeMorgage: Bool) {
        checkForGeneralBills()
        dao.changeMorgageInclude(user: user, includeMorgage: includeMorgage)
        if includeMorgage {
            if generalBills.contains("Morgage") { return }
            generalBills.append("Morgage")
        } else {
            generalBills = removeElementInArray(dataArray: generalBills, keyWord: "Morgage")
        }
    }
    
    func changeElectricityInclude(user: User, includeElectricity: Bool) {
        checkForElementBills()
        dao.changeElectricityInclude(user: user, includeElectricity: includeElectricity)
        if includeElectricity {
            if elementBills.contains("Electricity") { return }
            elementBills.append("Electricity")
        } else {
            elementBills = removeElementInArray(dataArray: elementBills, keyWord: "Electricity")
        }
    }
    
    func changeGasInclude(user: User, includeGas: Bool) {
        checkForElementBills()
        dao.changeGasInclude(user: user, includeGas: includeGas)
        if includeGas {
            if elementBills.contains("Gas") { return }
            elementBills.append("Gas")
        } else {
            elementBills = removeElementInArray(dataArray: elementBills, keyWord: "Gas")
        }
    }
    
    func changeWaterInclude(user: User, includeWater: Bool) {
        checkForElementBills()
        dao.changeWaterInclude(user: user, includeWater: includeWater)
        if includeWater {
            if elementBills.contains("Water") { return }
            elementBills.append("Water")
        } else {
            elementBills = removeElementInArray(dataArray: elementBills, keyWord: "Water")
        }
    }
    
    func changePropertyTaxInclude(user: User, includePropertyTax: Bool) {
        checkForGeneralBills()
        dao.changePropertyTaxInclude(user: user, includePropertyTax: includePropertyTax)
        if includePropertyTax {
            if generalBills.contains("Property Tax") { return }
            generalBills.append("Property Tax")
        } else {
            generalBills = removeElementInArray(dataArray: generalBills, keyWord: "Property Tax")
        }
    }
    
    func changeHouseKeepInclude(user: User, includeHouseKeep: Bool) {
        checkForGeneralBills()
        dao.changeHouseKeepInclude(user: user, includeHouseKeep: includeHouseKeep)
        if includeHouseKeep {
            if generalBills.contains("House Keep") { return }
            generalBills.append("House Keep")
        } else {
            generalBills = removeElementInArray(dataArray: generalBills, keyWord: "House Keep")
        }
    }
    
    func changeCarOwnership(user: User, isCarOwner: Bool) {
        dao.changeCarOwnership(user: user, isCarOwner: isCarOwner)
        if isCarOwner {
            if !typeOfBills.contains("Car") {
                typeOfBills.append("Car")
            }
        } else {
            typeOfBills = removeElementInArray(dataArray: typeOfBills, keyWord: "Car")
        }
    }
    
    func changeCarGas(user: User, includeCarGas: Bool) {
        dao.changeCarGas(user: user, includeCarGas: includeCarGas)
        if includeCarGas {
            if carBills.contains("Gas") { return }
            carBills.append("Gas")
        } else {
            carBills = removeElementInArray(dataArray: carBills, keyWord: "Gas")
        }
    }
    
    func changeCarTest(user: User, includeCarTest: Bool) {
        dao.changeCarTest(user: user, includeCarTest: includeCarTest)
        if includeCarTest {
            if carBills.contains("Test") { return }
            carBills.append("Test")
        } else {
            carBills = removeElementInArray(dataArray: carBills, keyWord: "Test")
        }
    }
    
    func changeCarReports(user: User, includeCarReports: Bool) {
        dao.changeCarReports(user: user, includeCarReports: includeCarReports)
        if includeCarReports {
            if carBills.contains("Reports") { return }
            carBills.append("Reports")
        } else {
            carBills = removeElementInArray(dataArray: carBills, keyWord: "Reports")
        }
    }
    
    // MARK: Get Bills Lists
    
    func getList(listType: String) -> [Bill] {
        let allBills = dao.getAllBills(currentUser: user!)
        var billsList: [Bill] = []
        for bill in allBills {
            let type = bill.type?.lowercased()
            if type!.elementsEqual(listType.lowercased()){
                billsList.append(bill)
            }
        }
        return billsList
    }
    
    // MARK: Private functions
    
    private func removeElementInArray(dataArray: [String], keyWord: String) -> [String] {
        var array = dataArray
        if array.isEmpty { return [] }
        for i in 0...array.count - 1 {
            if array[i] == keyWord {
                array.remove(at: i)
                return array
            }
        }
        return array
    }
    
    private func checkForGeneralBills() {
        if user!.includeHouseKeep || user!.includePropertyTax || user!.includeMorgage || !user!.isOwner {
            if !typeOfBills.contains("General") {
                typeOfBills.append("General")
            }
        } else {
            typeOfBills = removeElementInArray(dataArray: typeOfBills, keyWord: "General")        }
    }
    
    private func checkForElementBills() {
        if user!.includeWater || user!.includeGas || user!.includeElectricity {
            if !typeOfBills.contains("Elements") {
                typeOfBills.append("Elements")
            }
        } else {
            typeOfBills = removeElementInArray(dataArray: typeOfBills, keyWord: "Elements")
        }
    }
    
    private func typeOfBillsSort(array: [String]) -> [String] {
        var sortedArray: [String] = []
        if array.contains("Elements") { sortedArray.append("Elements") }
        if array.contains("General") { sortedArray.append("General") }
        if array.contains("Car") { sortedArray.append("Car") }
        
        return sortedArray
    }
    
    private func elementSort(array: [String]) -> [String] {
        var sortedArray: [String] = []
        if array.contains("Electricity") { sortedArray.append("Electricity") }
        if array.contains("Water") { sortedArray.append("Water") }
        if array.contains("Gas") { sortedArray.append("Gas") }
        
        return sortedArray
    }
    
    private func generalSort(array: [String]) -> [String] {
        var sortedArray: [String] = []
        if array.contains("Morgage") {sortedArray.append("Morgage") }
        if array.contains("Rent") { sortedArray.append("Rent") }
        if array.contains("Property Tax") { sortedArray.append("Property Tax") }
        if array.contains("House Keep") { sortedArray.append("House Keep")}
        
        return sortedArray
    }
    
    private func carSort(array: [String]) -> [String] {
        var sortedArray: [String] = []
        if array.contains("Gas") { sortedArray.append("Gas") }
        if array.contains("Test") { sortedArray.append("Test") }
        if array.contains("Reports") { sortedArray.append("Reports") }
        
        return sortedArray
    }
    
}
