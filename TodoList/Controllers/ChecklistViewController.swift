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
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int{
        return ArrayCheckListItem.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureText(for: cell, withItem: ArrayCheckListItem[indexPath.item])
        configureCheckmark(for: cell, withItem: ArrayCheckListItem[indexPath.row])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ArrayCheckListItem[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        ArrayCheckListItem.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.accessoryType = item.checked ?  .checkmark : .none
    }
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
        cell.textLabel?.text = item.text
    }
    
    @IBAction func addDummyTodo(_ sender: Any) {
    ArrayCheckListItem.append(ChecklistItem(text:"Dummies",checked:true))
        tableView.insertRows(at: [IndexPath(row: ArrayCheckListItem.count-1, section: 0)], with: .automatic)
    }
    
}

extension ChecklistViewController: AddItemViewControllerDelegate{
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        <#code#>
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        <#code#>
    }
    
    
}

