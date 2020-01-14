//
//  BillsListViewController.swift
//  HeTeC
//
//  Created by damir hodez on 09/01/2020.
//  Copyright © 2020 damir hodez. All rights reserved.
//

import UIKit

class BillsListViewController: UIViewController {
    
    var listChoosed = ""
    var billsList: [Bill] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(listChoosed)
        
        billsList = UserManaging.shared.getList(listType: listChoosed)
        
        print(billsList[0].type)
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

extension BillsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableItem = tableView.dequeueReusableCell(withIdentifier: "billCellItem") as! BillTableCell
        
        return tableItem
    }


}
