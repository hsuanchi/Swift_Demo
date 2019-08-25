//
//  MenuTableViewController.swift
//  swift_firebase
//
//  Created by Max on 2019/8/21.
//  Copyright © 2019 Max. All rights reserved.
//

import UIKit

struct CoffeeData: Decodable {
    var name: String
    var city: String
    var address: String
}

class MenuListTableViewCell: UITableViewCell {
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
}

class MenuTableViewController: UITableViewController {
    var shopName:[String] = []
    var shopCity:[String] = []
    var shopAddress:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getCoffeeData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopName.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Product_cell", for: indexPath) as! MenuListTableViewCell
        cell.productLabel.text = shopName[indexPath.row]
        cell.priceLabel.text = shopCity[indexPath.row]
        return cell
    }
    
    func getCoffeeData() {
        let address = "https://cafenomad.tw/api/v1.2/cafes/taipei"
        if let url = URL(string: address) {
            // GET
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let response = response as? HTTPURLResponse,let data = data {
                    print("Status code: \(response.statusCode)")
                    let decoder = JSONDecoder()
                    
                    if let coffeeData = try? decoder.decode([CoffeeData].self, from: data) {
                        DispatchQueue.main.async{
                        for coffee in coffeeData {                   self.shopName.append(coffee.name)
                            self.shopCity.append(coffee.city)
                        }
                            self.tableView.reloadData()
                        }
                    }
                }
            }.resume()
        } else {
            print("Invalid URL.")
        }
    }

}

