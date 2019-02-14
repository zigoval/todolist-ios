//
//  ViewController.swift
//  TodoList
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var ArrayCheckListItem = [ChecklistItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ArrayCheckListItem.append(ChecklistItem(text:"Finir le cours d’iOS"))
    ArrayCheckListItem.append(ChecklistItem(text:"Mettre à jour XCode",checked:true))
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int{return ArrayCheckListItem.count}
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureText(for: cell, withItem: ArrayCheckListItem[indexPath.row])
        configureCheckmark(for: cell, withItem: ArrayCheckListItem[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.accessoryType = item.checked ?  .checkmark : .none
    }
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.textLabel?.text = item.text
    }
    
}

