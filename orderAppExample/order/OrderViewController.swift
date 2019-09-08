//
//  OrderViewController.swift
//  order
//
//  Created by Max on 2019/8/30.
//  Copyright © 2019 Max. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var imgLabel: UIImageView!
    
    func setCellData(with cellData: DrinkData) {
        nameLabel.text = cellData.name
        contentLabel.text = cellData.content
        detailLabel.text = cellData.eng_content
        priceLabel.text = cellData.price
        imgLabel.image = UIImage(named: cellData.image!)
    }
}

class OrderTypeTableViewCell: UITableViewCell {

}

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var OrderTabelView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderTableViewCell

        cell.setCellData(with: cellData!)
        return cell
    }

    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
//        UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for:
//            indexPath) as? OrderTableViewCell,indexPath.row == 0 else{
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTypeCell", for: indexPath) as? OrderTypeTableViewCell,indexPath.row == 1 else {
//                return UITableViewCell()
//            }
//
//            return cell
//        }
//        cell.setCellData(with: cellData!)
//        return cell
//    }

    

    var cellData: DrinkData?
 
    override func viewDidLoad() {        super.viewDidLoad()
        OrderTabelView.delegate = self
        OrderTabelView.dataSource = self
        // Do any additional setup after loading the view.
    }
}
