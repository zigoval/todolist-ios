//
//  AllListViewController.swift
//  TodoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    var listes = ["Liste1","Liste2","Liste3"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForList", for: indexPath)
        cell.textLabel?.text = listes[indexPath.item]
        return cell
    
    //cellForList
}


}
