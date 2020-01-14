//
//  newBillViewController.swift
//  HeTeC
//
//  Created by damir hodez on 22/12/2019.
//  Copyright © 2019 damir hodez. All rights reserved.
//

import UIKit

class NewBillViewController: UIViewController {

    @IBOutlet weak var billsTypeOption: UIPickerView!
    @IBOutlet var pickerWindow: UIView!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet var datePickerWindow: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    // type button -> index 0
    // start button -> index 1
    // end button -> index 2
    @IBOutlet var pickerButtonCollection: [UIButton]!
    
    let pickerDataSource = StringsCollection.newBillType
    var typeSelected: String = ""
    var whichDateField: String = ""
    var dateSelected: Date?
    let dateFormat: String = "dd/MM/yyyy"
    var newBill: Bill = UserManaging.shared.createNewBill()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billsTypeOption.dataSource = self as UIPickerViewDataSource
        billsTypeOption.delegate = self as UIPickerViewDelegate
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        
        valueField.keyboardType = .numberPad
        
        // disabling the keyboard from appearing
//        typeField.inputView = UIView()
        fieldsFirstSetup()
        valueFieldDesign()
        pickerWindowSetUp()
        datePickerWindowSetUp()
        pickerViewButtonsDesign(pickerButtonCollection)
    }
    
    
    @IBAction func saveBill(_ sender: UIButton) {
        fieldsCleanDesign()
        
        if valueField.text!.isEmpty { valueField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) }
        if newBill.type == nil { pickerButtonCollection[0].layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) }
        if newBill.startDate == nil { pickerButtonCollection[1].layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) }
        if newBill.endDate == nil { pickerButtonCollection[2].layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1) }
        
        let userManaging = UserManaging.shared
        newBill.user = userManaging.user
        userManaging.addBill(user: userManaging.user!, newBill: newBill)
        userManaging.user!.addToBills(newBill)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        valueField.endEditing(true)
        if !pickerWindow.isHidden { hidePickerWindow() }
        if !datePicker.isHidden { hideDatePickerWindow() }
    }
    
    // MARK: Buttons of button collection
    
    @IBAction func typeSelectButton(_ sender: UIButton) {
        if !datePickerWindow.isHidden { hideDatePickerWindow() }
        pickerWindow.isHidden = false
    }
    
    @IBAction func dateStartPicker(_ sender: UIButton) {
        if !pickerWindow.isHidden { hidePickerWindow() }
        showDatePickerWindow()
        whichDateField = "start"
    }
    
    @IBAction func dateEndPicker(_ sender: UIButton) {
        if !pickerWindow.isHidden { hidePickerWindow() }
        showDatePickerWindow()
        whichDateField = "end"
    }
    
    // MARK: UIView - Type Picker
    
    @IBAction func pickerWindowDoneButton(_ sender: UIButton) {
        hidePickerWindow()
        let typeButton = pickerButtonCollection[0]
        typeButton.setTitle(typeSelected, for: .normal)
        buttonDesignAfterChoosing(button: typeButton)
        newBill.type = typeSelected
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeSelected = pickerDataSource[row]
    }
    
    // MARK: UIView - Date Picker
    
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        dateSelected = datePicker.date
    }
    
    @IBAction func datePickerDoneButton(_ sender: UIButton) {
        hideDatePickerWindow()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        if whichDateField == "start" {
            // 0 is the start button
            let fromButton = pickerButtonCollection[1]
            fromButton.setTitle(dateFormatter.string(from: dateSelected!), for: .normal)
            buttonDesignAfterChoosing(button: fromButton)
            newBill.startDate = dateSelected
        } else if whichDateField == "end" {
            // 1 is the end button
            let toButton = pickerButtonCollection[2]
            toButton.setTitle(dateFormatter.string(from: dateSelected!), for: .normal)
            buttonDesignAfterChoosing(button: toButton)
            newBill.endDate = dateSelected
        }
    }
    
    // MARK: UIView hide/ show
    
    func showDatePickerWindow() {
        datePickerWindow.isHidden = false
    }
    
    func hideDatePickerWindow() {
        datePickerWindow.isHidden = true
    }
    
    func hidePickerWindow() {
        pickerWindow.isHidden = true
    }
    
    // MARK: Design and Setup
    
    func fieldsFirstSetup() {
        typeSelected = pickerDataSource[0]
        dateSelected = datePicker.date
    }
    
    func datePickerWindowSetUp() {
        datePickerWindow.isHidden = true
        datePickerWindow.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: 170)
        datePickerWindow.center = CGPoint(x: view.center.x, y: view.center.y)
        datePickerWindow.layer.cornerRadius = 10
        datePickerWindow.layer.borderWidth = 2
        datePickerWindow.layer.borderColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        view.addSubview(datePickerWindow)
    }
    
    func pickerWindowSetUp() {
        pickerWindow.isHidden = true
        pickerWindow.frame = CGRect(x: 0, y: 0, width: view.frame.width - 32, height: 170)
        pickerWindow.center = CGPoint(x: view.center.x, y: view.center.y)
        pickerWindow.layer.cornerRadius = 10
        pickerWindow.layer.borderWidth = 2
        pickerWindow.layer.borderColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        view.addSubview(pickerWindow)
    }
    
    func pickerViewButtonsDesign(_ buttonsCollection: [UIButton]) {
        for button in buttonsCollection {
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 2
            button.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        }
    }
    
    func buttonDesignAfterChoosing(button: UIButton) {
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
    }
    
    func valueFieldDesign() {
        valueField.layer.borderWidth = 2
        valueField.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        valueField.layer.cornerRadius = 10
        valueField.clipsToBounds = true
    }
    
    func fieldsCleanDesign() {
        for button in pickerButtonCollection {
            button.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        }
        valueField.layer.borderColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: Extention

extension NewBillViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
}


