//
//  AllListViewController.swift
//  TodoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    var lists = [CheckList]()
    var liste1 = CheckList(name: "Fr", item: (nil))
    var liste2 = CheckList(name: "Eng", item: (nil))
    var liste3 = CheckList(name: "Jp", item: (nil))
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        lists.append(liste1)
        lists.append(liste2)
        lists.append(liste3)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! ChecklistViewController
        destVC.list = lists[(tableView.indexPath(for: sender as! UITableViewCell)?.row)!]
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForList", for: indexPath)
        cell.textLabel?.text = lists[indexPath.item].name
        return cell
    
    //cellForList
}


}
