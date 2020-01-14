//
//  ProfileStattingsViewController.swift
//  HeTeC
//
//  Created by damir hodez on 02/01/2020.
//  Copyright © 2020 damir hodez. All rights reserved.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    
        // storyboard outlets //
    //----------------------------------------------//
    @IBOutlet weak var newFullNameField: UITextField!
    
    @IBOutlet weak var changePassOldField: UITextField!
    @IBOutlet weak var changePassNewField: UITextField!
    @IBOutlet weak var changePassConfirmField: UITextField!
    
    @IBOutlet weak var changeNameView: UIView!
    @IBOutlet weak var changePassView: UIView!
    //----------------------------------------------//
    
    // animation duration //
    let animationDuration: Double = 0.3
    
    // usefull variables //
    var user = UserManaging.shared.user!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeNameView.isHidden = true
        changePassView.isHidden = true
        newFullNameField.text = user.name
        cleanFieldsDesign(fieldsArray: [newFullNameField, changePassOldField, changePassNewField, changePassConfirmField])
        
    }
    
    // MARK: Buttons Action
    
    // 1) only one of the list buttons can stay open at a time
    // when ever the user tapping to other list button while one is already open
    // it will close the one that open, and than open the tapped one
    
    // 2) tapping on already open list button will close it
    
    @IBAction func changeFullNameButton(_ sender: UIButton) {
        if !changePassView.isHidden { hideView(view: changePassView) }
        if changeNameView.isHidden {
            showView(view: changeNameView)
        } else {
            hideView(view: changeNameView)
        }
    }
    
    @IBAction func changePasswordButton(_ sender: UIButton) {
        if !changeNameView.isHidden { hideView(view: changeNameView) }
        if changePassView.isHidden {
            showView(view: changePassView)
        } else {
            hideView(view: changePassView)
        }
    }
    
    // MARK: Save Buttons
    
    // let the user change his full name a desire, and saves it on userManaging and than to core data
    @IBAction func fullNameSaveButton(_ sender: UIButton) {
        let newName = newFullNameField.text!
        UserManaging.shared.changeName(user: user, newName: newName)
    }
    
    // let the user change their password
    @IBAction func changePassSaveButton(_ sender: UIButton) {
        // make clean design for fields -> no error as for start
        cleanFieldsDesign(fieldsArray: [changePassOldField, changePassNewField, changePassConfirmField])
        // get old password writen by the user for comparison
        let oldPassword = changePassOldField.text!
        
        // compare the old password writen by user to the real one
        if oldPassword == user.password {
            
            // password currect -> true
            // compare the new password with its confirmed password
            if changePassNewField.text! == changePassConfirmField.text! {
                
                // the confirmation was correct, so saves the new password
                UserManaging.shared.changePassword(user: user, newPassword: changePassNewField.text!)
            } else {
                // confirmation was incorrect, so designing changePassNewField and changePassConfirmField
                // so the user will know the confirmation was incorrect
                errorFieldsDesign(fieldsArray: [changePassNewField, changePassConfirmField])
                return
            }
        } else {
            // the comparison was incorrect, so design the changePassOldField so the user will know
            // that the password was incorrect
            errorFieldsDesign(fieldsArray: [changePassOldField])
            return
        }
    }
    
    // MARK: Design
    
    func errorFieldsDesign(fieldsArray: [UITextField]) {
        for field in fieldsArray {
            field.layer.borderWidth = 1
            field.layer.borderColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        }
    }
    
    func cleanFieldsDesign(fieldsArray: [UITextField]) {
        for field in fieldsArray {
            field.layer.borderWidth = 1
            field.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            field.layer.cornerRadius = 10
            field.clipsToBounds = true
        }
    }
    
    // MARK: Views Display
    
    func hideView(view: UIView) {
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
            view.isHidden = true
        }
    }
    
    func showView(view: UIView) {
        UIView.animate(withDuration: animationDuration) {
            view.layoutIfNeeded()
            view.isHidden = false
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
