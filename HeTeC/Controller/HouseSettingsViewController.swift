//
//  HouseStattingsViewController.swift
//  HeTeC
//
//  Created by damir hodez on 02/01/2020.
//  Copyright © 2020 damir hodez. All rights reserved.
//

import UIKit

class HouseSettingsViewController: UIViewController {
    
    // storyboard outlets //
    // ---------------------------------------------//
    @IBOutlet weak var ownershipButton: UIButton!
    @IBOutlet weak var billsButton: UIButton!
    @IBOutlet weak var carButton: UIButton!
    
    @IBOutlet weak var ownershipView: UIView!
    @IBOutlet weak var ownerBoughtView: UIView!
    @IBOutlet weak var ownerRentView: UIView!
    @IBOutlet weak var billsView: UIView!
    @IBOutlet weak var carView: UIView!
    
    @IBOutlet weak var boughtSwitch: UISwitch!
    @IBOutlet weak var rentedSwitch: UISwitch!
    @IBOutlet weak var morgageSwitch: UISwitch!
    
    @IBOutlet weak var electricitySwitch: UISwitch!
    @IBOutlet weak var waterSwitch: UISwitch!
    @IBOutlet weak var gasSwitch: UISwitch!
    @IBOutlet weak var propertyTaxSwitch: UISwitch!
    @IBOutlet weak var houseKeepSwitch: UISwitch!
    
    @IBOutlet weak var carSwitch: UISwitch!
    @IBOutlet weak var carGasSwitch: UISwitch!
    @IBOutlet weak var carTestSwitch: UISwitch!
    @IBOutlet weak var carReportsSwitch: UISwitch!
    
    @IBOutlet weak var morgageValueField: UITextField!
    @IBOutlet weak var rentedValueField: UITextField!
    
    @IBOutlet weak var ownershipViewHeight: NSLayoutConstraint!
    @IBOutlet weak var boughtViewHeight: NSLayoutConstraint!
    @IBOutlet weak var carViewHeight: NSLayoutConstraint!
    // ---------------------------------------------//
    
    // height variables //
    // ---------------------------------------------//
    var ownershipViewOffHeight: CGFloat = 0
    var ownershipViewBoughtOnHeight: CGFloat = 0
    var ownershipViewRentOnHeight: CGFloat = 0
    var boughtViewOpenHeight: CGFloat = 0
    var boughtViewCloseHeight: CGFloat = 0
    var carViewCloseHeight: CGFloat = 0
    var carViewOpenHeight: CGFloat = 0
    // ---------------------------------------------//
    
    // animation duration //
    let animationDuration: Double = 0.3
    
    // usefull variables //
    let userManaging = UserManaging.shared
    let user = UserManaging.shared.user!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            // formatted height for each view //
        // ---------------------------------------------//
        ownershipViewOffHeight = view.frame.height * 0.1
        ownershipViewBoughtOnHeight = view.frame.height * 0.21
        boughtViewOpenHeight = view.frame.height * 0.16
        boughtViewCloseHeight = view.frame.height * 0.05
        ownershipViewRentOnHeight = view.frame.height * 0.16
        carViewCloseHeight = view.frame.height * 0.05
        carViewOpenHeight = view.frame.height * 0.2
        // ---------------------------------------------//
        
            // fields only contains numberPads //
        // ---------------------------------------------//
        morgageValueField.keyboardType = .numberPad
        rentedValueField.keyboardType = .numberPad
        // ---------------------------------------------//
        
        // setup for switchs by user's remembered data //
        // ---------------------------------------------//
        boughtSwitch.isOn = user.isOwner
        morgageSwitch.isOn = user.includeMorgage
        rentedSwitch.isOn = !user.isOwner
        
        electricitySwitch.isOn = user.includeElectricity
        waterSwitch.isOn = user.includeWater
        gasSwitch.isOn = user.includeGas
        propertyTaxSwitch.isOn = user.includePropertyTax
        houseKeepSwitch.isOn = user.includeHouseKeep
        
        carSwitch.isOn = user.includeCar
        carGasSwitch.isOn = user.includeCarGas
        carTestSwitch.isOn = user.includeCarTest
        carReportsSwitch.isOn = user.includeCarReports
        
        ownershipViewHeight.constant = boughtSwitch.isOn ? ownershipViewBoughtOnHeight : ownershipViewRentOnHeight
        boughtViewHeight.constant = boughtSwitch.isOn ? boughtViewOpenHeight : boughtViewCloseHeight
        carViewHeight.constant = carSwitch.isOn ? carViewOpenHeight : carViewCloseHeight
        
        ownershipView.isHidden = true
        ownerBoughtView.isHidden = !boughtSwitch.isOn
        ownerRentView.isHidden = boughtSwitch.isOn
        billsView.isHidden = true
        carView.isHidden = true
        // ---------------------------------------------//
        
        if !morgageSwitch.isOn {morgageValueField.isEnabled = false}
    }
    
    // MARK: Button Actions
    
    // ownershipButton(), billsButton and carButton only one of the can stay opened at a time
    // when ever you tap other button while one is already open, it will close what's open
    // and will open what ever the user tapped
    
    // tapping on already open button, will close it
    
    @IBAction func ownershipButton(_ sender: UIButton) {
        if (!billsView.isHidden || !carView.isHidden) {
            hideView(view: billsView)
            hideView(view: carView)
        }
        if ownershipView.isHidden {
            showView(view: ownershipView)
        } else {
            hideView(view: ownershipView)
        }
    }
    
    @IBAction func billsButton(_ sender: UIButton) {
        if (!ownershipView.isHidden || !carView.isHidden) {
            hideView(view: ownershipView)
            hideView(view: carView)
        }
        if billsView.isHidden {
            showView(view: billsView)
        } else {
            hideView(view: billsView)
        }
    }
    
    @IBAction func carButton(_ sender: UIButton) {
        if (!ownershipView.isHidden || !billsView.isHidden) {
            hideView(view: ownershipView)
            hideView(view: billsView)
        }
        if carView.isHidden {
            showView(view: carView)
        } else {
            hideView(view: carView)
        }
    }
    
    
    // MARK: Switches Actions
    
    // boughtSwitchChanged() and rentSwitchChanged are triggering each other
    // cause there must be bought appatment or rented appartment
    // but could not be none of the.
    // it has to be one of them, so when ever one of them turned off it switches the other ones and triggers it
    
    // bought switch changes functionality
    @IBAction func boughtSwitchChangend(_ sender: UISwitch) {
        // save to user by userManagin. and than to core data
        userManaging.changeOwnership(user: user, isOwner: sender.isOn)
        
        if rentedSwitch.isOn {
            // rent switch in on -> true
            // turn if off and hide rentView
            rentedSwitch.isOn = false
            hideView(view: ownerRentView)
            
        }
        if sender.isOn {
            // bought is on -> true
            // make appropriate height for it
            // and open the bought view animated
            self.ownershipViewHeight.constant = ownershipViewBoughtOnHeight
            self.boughtViewHeight.constant = boughtViewOpenHeight
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
            // show bought view
            self.showView(view: self.ownerBoughtView)
        } else {
            // bought switch is off -> false
            // close the bought view and hide it
            self.boughtViewHeight.constant = boughtViewCloseHeight
            self.hideView(view: self.ownerBoughtView)
            
            // turn rent switch on and trigger its valueChanged function
            rentedSwitch.isOn = true
            rentedSwitchChanged(rentedSwitch)
        }
    }
    
    // morgage switch changes functionality
    @IBAction func morgageSwitchChanged(_ sender: UISwitch) {
        // save to user by userManagin. and than to core data
        userManaging.changeMorgageInclude(user: user, includeMorgage: sender.isOn)
        
        if sender.isOn {
            // enable the field if the user pay morgage
            morgageValueField.isEnabled = true
        } else {
            // disable the field if the user dont pay morgage
            morgageValueField.isEnabled = false
        }
    }
    
    // rented switch changes functionality
    @IBAction func rentedSwitchChanged(_ sender: UISwitch) {
        // save to user by userManagin. and than to core data
        userManaging.changeOwnership(user: user, isOwner: !sender.isOn)
        
        if boughtSwitch.isOn {
            // only bought or renter
            // bought switch is on -> true
            
            // close the bought view and hide it
            self.boughtViewHeight.constant = boughtViewCloseHeight
            self.hideView(view: self.ownerBoughtView)
            // turn it off
            boughtSwitch.isOn = false
        }
        if sender.isOn {
            // rent switch is on -> true
            // make appropriate height to the rent view animated
            self.ownershipViewHeight.constant = ownershipViewRentOnHeight
            UIView.animate(withDuration: animationDuration) { self.view.layoutIfNeeded() }
            
            // show the view
            showView(view: ownerRentView)
            
            // if morgage switch in bought view was on -> turn in off and save changes
            morgageSwitch.isOn = false
            morgageSwitchChanged(morgageSwitch)
        } else {
            // rent switch is off -> false
            // turn bought switch on and trigger it valueChanged function
            boughtSwitch.isOn = true
            boughtSwitchChangend(boughtSwitch)
            return
        }
    }
    
    // car switch changes functionality
    @IBAction func carSwitchChanged(_ sender: UISwitch) {
        // save to user by userManaging, and than to core data
        userManaging.changeCarOwnership(user: user, isCarOwner: sender.isOn)
        if sender.isOn {
            // sender is on -> true
            // make appropriate height, animated
            carViewHeight.constant = carViewOpenHeight
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
            // turn all car related switches to true as defult
            carGasSwitch.isOn = true
            carTestSwitch.isOn = true
            carReportsSwitch.isOn = true
        } else {
            // sender if off -> false
            // make appropriate height, animated
            carViewHeight.constant = carViewCloseHeight
            UIView.animate(withDuration: animationDuration) {
                self.view.layoutIfNeeded()
            }
            // turn all car related switches off cause there is no car
            carGasSwitch.isOn = false
            carTestSwitch.isOn = false
            carReportsSwitch.isOn = false
        }
        // remember all changes to user, after that to core data
        carGasChanged(carGasSwitch)
        carTestChanged(carTestSwitch)
        carReportsChanged(carReportsSwitch)
    }
    
    
    // remembering the changes of the user, updating the user by userManaging and
    // than from userManaging saves all in data core
    
    @IBAction func electricitySwitchChanged(_ sender: UISwitch) {
        userManaging.changeElectricityInclude(user: user, includeElectricity: sender.isOn)
    }
    @IBAction func waterSwitchChanged(_ sender: UISwitch) {
        userManaging.changeWaterInclude(user: user, includeWater: sender.isOn)
    }
    @IBAction func gasSwitchChanged(_ sender: UISwitch) {
        userManaging.changeGasInclude(user: user, includeGas: sender.isOn)
    }
    @IBAction func propertyTaxSwitchChanged(_ sender: UISwitch) {
        userManaging.changePropertyTaxInclude(user: user, includePropertyTax: sender.isOn)
    }
    @IBAction func houseKeepSwitchChanged(_ sender: UISwitch) {
        userManaging.changeHouseKeepInclude(user: user, includeHouseKeep: sender.isOn)
    }
    @IBAction func carGasChanged(_ sender: UISwitch) {
        userManaging.changeCarGas(user: user, includeCarGas: sender.isOn)
    }
    @IBAction func carTestChanged(_ sender: UISwitch) {
        userManaging.changeCarTest(user: user, includeCarTest: sender.isOn)
    }
    @IBAction func carReportsChanged(_ sender: UISwitch) {
        userManaging.changeCarReports(user: user, includeCarReports: sender.isOn)
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
