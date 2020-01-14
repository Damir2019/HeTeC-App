//
//  SignInViewController.swift
//  HeTeC
//
//  Created by damir hodez on 26/12/2019.
//  Copyright © 2019 damir hodez. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    var user: User? = nil

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordRepeatedField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet var textFieldsArray: [UITextField]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fieldCleanDesign()
    }
    
    @IBAction func signInButton(_ sender: UIButton) {
        fieldCleanDesign()
        if emptyFields() {
            fieldErrorDesign()
            return}
        
        if checkPasswordForCurrection() {
            let newUsername = usernameField.text!
            let newPassword = passwordField.text!
            let newName = nameField.text!
            
            let userManaging = UserManaging.shared
            userManaging.addNewUser(username: newUsername, password: newPassword, name: newName)
            //userManaging.loginToUser(username: newUsername, password: newPassword)
           // let user = DAO.shared.logInToUser(username: newUsername, password: newPassword)
            //UserManaging.shared.rememberUser(user: user!)
            
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    func checkPasswordForCurrection() -> Bool {
        return passwordField.text == passwordRepeatedField.text ? true : false
    }
    
    func emptyFields() -> Bool {
        return usernameField.text!.isEmpty || passwordField.text!.isEmpty || passwordRepeatedField.text!.isEmpty || nameField.text!.isEmpty
    }
    
    func fieldCleanDesign() {
        for textField in textFieldsArray {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        }
    }
    
    func fieldErrorDesign() {
        for textField in textFieldsArray {
            if textField.text!.isEmpty {
                textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            }
        }
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


