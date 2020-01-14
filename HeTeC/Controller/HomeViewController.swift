//
//  HomeViewCell.swift
//  HeTeC
//
//  Created by damir hodez on 19/12/2019.
//  Copyright © 2019 damir hodez. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var user: User?
    @IBOutlet weak var categoryCV: UICollectionView!
    
    override func viewDidLoad() {
        // code
        categoryCV.register(UINib(nibName: "HomePageCellItem", bundle: nil), forCellWithReuseIdentifier: "homePageCell")
        
//        DAO.shared.removeAllUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        user = UserManaging.shared.lastLoggedUser()
        super.viewDidAppear(animated)
        if user == nil{
            goToLogInPage()
        } else {
            self.user = user!
            UserManaging.shared.checkForInclude(user: user!)
        }
        DAO.shared.printAllUsersBills()
        
        
    }
    
    func goToLogInPage() {
        self.performSegue(withIdentifier: "loginPage", sender: self)
    }
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StringsCollection.categoryLabelDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homePageCell", for: indexPath) as! HomePageCellItem
        let labelDataArray = StringsCollection.categoryLabelDataSource
        
        cell.frame = CGRect(origin: CGPoint(x: 0, y:  (Int(cell.frame.height) * indexPath.item ) + (16 * indexPath.item)) , size: CGSize(width: Int(view.frame.width) - 32, height: Int(cell.frame.height)) )
        
        cell.categoryLabel.text = labelDataArray[indexPath.item]
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.item == 0) {
            // new bill page
            self.performSegue(withIdentifier: "addNewBill", sender: self)
        } else if (indexPath.item == 1) {
            // view bill page
            self.performSegue(withIdentifier: "goToBills", sender: self)
        } else if (indexPath.item == 2) {
            // statistic page
            self.performSegue(withIdentifier: "goToStatistic", sender: self)
        } else if (indexPath.item == 3) {
            self.performSegue(withIdentifier: "goToProfile", sender: self)
            return
        }
    }
    
    
}
