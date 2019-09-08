//
//  ViewController.swift
//  order
//
//  Created by Max on 2019/8/30.
//  Copyright © 2019 Max. All rights reserved.
//

import UIKit

struct DrinkData {
    var image: String?
    var name: String?
    var price: String?
    var content: String?
    var eng_content: String?
}


class MenuListTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    func update(with cellData: DrinkData) {
        name.text = cellData.name
        content.text = cellData.content
        detail.text = cellData.eng_content
        price.text = cellData.price
        img.image = UIImage(named: cellData.image!)
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.dataSource = self
        menuTableView.delegate = self
    }
    

    
    // 設定Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // 設定cell有幾行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContent.count
    }
    
    // 設定cell內資料
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! MenuListTableViewCell
        
        let cellData = cellContent[indexPath.row]
        cell.update(with: cellData)
        
        return cell
    }
    
    
    let cellContent = [
        DrinkData(image: "tea-1", name: "熟成紅茶", price: "$35.00", content: "解炸物或烤肉類油膩。果香。", eng_content: "Remove greasy of deep-fried food or grilled meat. Fruit scent."),
        DrinkData(image: "tea-2", name: "麗春紅茶", price: "$35.00", content: "去除海鮮羶腥。花香。", eng_content: "Remove fishy of seafood. Flower scent."),
        DrinkData(image: "tea-3", name: "太妃紅茶", price: "$45.00", content: "咖啡及茶。", eng_content: "Coffee and tea."),
        DrinkData(image: "tea-4", name: "熟成冷露", price: "35.00", content: "手工冬瓜及茶。", eng_content: "Handmade white gourd drinks and tea."),
        DrinkData(image: "tea-5", name: "雪花冷露", price: "$35.00", content: "手工冬瓜。", eng_content: "Handmade white gourd drinks."),
        DrinkData(image: "tea-6", name: "春芽冷露", price: "$35.00", content: "手工冬瓜及綠茶。", eng_content: "Handmade White Gourd Green Tea"),
        DrinkData(image: "tea-7", name: "春芽綠茶", price: "$35.00", content: "綠茶，系系中帶點彔彔。", eng_content: "Green Tea"),
        DrinkData(image: "tea-8", name: "春梅冰茶", price: "$45.00", content: "春梅與冬瓜相遇。", eng_content: "White Gourd Drinks with Plum"),
        DrinkData(image: "tea-9", name: "冷露歐蕾", price: "50.00", content: "手工冬瓜及鮮奶。", eng_content: "Handmade white gourd drinks and fresh milk."),
        DrinkData(image: "tea-10", name: "熟成歐蕾", price: "$50.00", content: "鮮奶茶。", eng_content: "Fresh milk tea."),
        DrinkData(image: "tea-11", name: "白玉歐蕾", price: "$60.00", content: "白玉珍珠奶茶。", eng_content: "Milk tea with white tapioca."),
        DrinkData(image: "tea-12", name: "熟成檸果", price: "$60.00", content: "中杯。每日限量。搭配少糖最佳。", eng_content: "Medium. Daily limited. Suggest sweetness level with 70% sugar. Cold drinks.")
        
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? OrderMaxTableViewController, let _ = menuTableView.indexPathForSelectedRow?.section, let row = menuTableView.indexPathForSelectedRow?.row {
            controller.cellData = cellContent[row]
        }
    }
    
}
