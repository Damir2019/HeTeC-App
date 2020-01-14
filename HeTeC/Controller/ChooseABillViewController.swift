//
//  ChooseABillViewController.swift
//  HeTeC
//
//  Created by damir hodez on 08/01/2020.
//  Copyright © 2020 damir hodez. All rights reserved.
//

import UIKit

class ChooseABillViewController: UIViewController {

    var typeUserChoosed = ""
    var choosenBills: [String] = []
    var billSelected = ""
    
    @IBOutlet weak var billCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if typeUserChoosed.elementsEqual("Elements") {
            choosenBills = UserManaging.shared.elementBills
        } else if typeUserChoosed.elementsEqual("General") {
            choosenBills = UserManaging.shared.generalBills
        } else if typeUserChoosed.elementsEqual("Car") {
            choosenBills = UserManaging.shared.carBills
        }
        
        print(choosenBills)
        
        billCollectionView.register(UINib(nibName: "BillsTypeCellItem", bundle: nil), forCellWithReuseIdentifier: "Bill")
        
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

extension ChooseABillViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return choosenBills.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // get the right cell
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Bill", for: indexPath) as! BillsTypeCellItem
        
        // changing the size of the cell to modify it to other screen sizes
        cell.frame.size = CGSize(width: Int(view.frame.width) - 32, height: Int(view.frame.height / 4) - 50)
        
        // starting point for the firt item
        let initialPoint = Int(view.frame.height * 0.1)
        
        // for the first item, i wanted to give different starting point, and of all other cell will be the same formula
        // keep spacing of 16
        var yPosition = Int(cell.frame.height + 16) * indexPath.item + initialPoint
        
        if indexPath.item == 0 {
            yPosition = initialPoint
        }
        
        // where the cell will be drawn
        cell.frame.origin = CGPoint(x: 16, y: yPosition)
        
        // allown me to add constraints from the code
        cell.billsPageCellStackView.translatesAutoresizingMaskIntoConstraints = false

        // changing the stack view size and fixing it to the center of the cell
        cell.billsPageCellStackView.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        cell.billsPageCellStackView.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        cell.billsPageCellStackView.heightAnchor.constraint(equalToConstant: cell.frame.height).isActive = true
        // cause a problem that braking constraints, to fix it i changed the width of the frame as shown below
    //        cell.billsPageCellStackView.widthAnchor.constraint(equalToConstant: cell.frame.width).isActive = true
        cell.billsPageCellStackView.frame.size.width = cell.frame.width - 128
        
        // set the text to the cells label
        cell.billPageCellLabel.text = choosenBills[indexPath.item]
        
        cell.isUserInteractionEnabled = true
        
        // border design
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 2
        cell.layer.borderColor = #colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        billSelected = choosenBills[indexPath.item]
        performSegue(withIdentifier: "goToList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let billList = segue.destination as! BillsListViewController
        billList.listChoosed = billSelected
    }
    
    
}
