//
//  LoginViewController.swift
//  HeTeC
//
//  Created by damir hodez on 26/12/2019.
//  Copyright © 2019 damir hodez. All rights reserved.
//


// check about localization for different languages


import UIKit

class LoginViewController: UIViewController {

    let dao = DAO.shared
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet var textFieldsArray: [UITextField]!
    @IBOutlet weak var loginButtonOut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dao.printAllUsersBills()
        fieldCleanDesign()
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fieldCleanDesign()
        let user = UserManaging.shared.user
        print("log")
        if user == nil {return}
        
        usernameField.text = user!.username
        passwordField.text = user!.password
        logInButton(loginButtonOut)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for field in textFieldsArray {
            field.endEditing(true)
        }
    }
    
    @IBAction func logInButton(_ sender: UIButton) {
        dao.printAllUsersName()
        fieldCleanDesign()
        if checkEmptyFields() {
            fieldErrorDesign()
            return
        }
        guard let user = UserManaging.shared.loginToUser(username: usernameField.text!, password: passwordField.text!)
            else {
                for textField in textFieldsArray {
                    textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                }
            return
        }
        dao.changeLastLogged(user: user, lastLogged: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SignInPage", sender: self)
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
                textField.layer.borderWidth = 1
                textField.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            }
        }
    }
    
    func checkEmptyFields() -> Bool {
        return usernameField.text!.isEmpty || passwordField.text!.isEmpty
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
