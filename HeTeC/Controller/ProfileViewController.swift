//
//  ProfileViewController.swift
//  HeTeC
//
//  Created by damir hodez on 29/12/2019.
//  Copyright © 2019 damir hodez. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var user = UserManaging.shared.user

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = user?.name
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        nameLabel.text = user?.name
    }
    
    @IBAction func profileStattingButton(_ sender: UIButton) {
        performSegue(withIdentifier: "profileStattingsPage", sender: self)
    }
    
    @IBAction func houseStattingsButton(_ sender: UIButton) {
        performSegue(withIdentifier: "houseStattingsPage", sender: self)
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        goToLogInPage()
        
        DAO.shared.changeLastLogged(user: user!, lastLogged: false)
        
        UserManaging.shared.user = nil
    }
    
    func goToLogInPage() {
        self.navigationController?.popViewController(animated: true)
//        DAO.shared.removeAllUsers()
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
