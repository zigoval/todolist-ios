//
//  ViewController.swift
//  TodoList
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var arrayCheckListItem = [ChecklistItem]()
        //MARK: - Init

    override func viewDidLoad() {
        super.viewDidLoad()
        arrayCheckListItem.append(ChecklistItem(text:"Finir le cours d’iOS"))
        arrayCheckListItem.append(ChecklistItem(text:"Mettre à jour XCode",checked:true))
    }

    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem"
        {
            let navDestVC = segue.destination as! UINavigationController
            let destVC = navDestVC.topViewController as! AddItemViewController
            destVC.delegate = self
        } else if segue.identifier == "editItem"
        {
            let navDestVC = segue.destination as! UINavigationController
            let destVC = navDestVC.topViewController as! AddItemViewController
            
            destVC.itemToEdit = arrayCheckListItem[(tableView.indexPath(for: sender as! UITableViewCell)?.row)!]
            destVC.delegate = self
        }
    }
    
    //MARK: - Table view delegate et data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int{
        return arrayCheckListItem.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureText(for: cell, withItem: arrayCheckListItem[indexPath.item])
        configureCheckmark(for: cell, withItem: arrayCheckListItem[indexPath.row])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrayCheckListItem[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        arrayCheckListItem.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    //MARK: - Configuration de la cellule
    
    func configureCheckmark(for cell: UITableViewCell, withItem item: ChecklistItem){
        let customCell = cell as! CheckListItemCell
        
        customCell.todoChecked.isHidden = item.checked ? false : true
        
    }
    func configureText(for cell: UITableViewCell, withItem item: ChecklistItem){
        let customCell = cell as! CheckListItemCell
        customCell.todoLabel.text = item.text
    }
    
    //MARK: -
    
    @IBAction func addDummyTodo(_ sender: Any) {
    arrayCheckListItem.append(ChecklistItem(text:"Dummies",checked:true))
        tableView.insertRows(at: [IndexPath(row: arrayCheckListItem.count-1, section: 0)], with: .automatic)
    }
    
}

//MARK: - Add Item View Controller Delegate

extension ChecklistViewController: AddItemViewControllerDelegate{
    func addItemViewControllerDidCancel(_ controller: AddItemViewController) {
        print("cancel")
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        print("Done")
        arrayCheckListItem.append(ChecklistItem(text:item.text,checked:false))
        tableView.insertRows(at: [IndexPath(row: arrayCheckListItem.count-1, section: 0)], with: .automatic)
        controller.dismiss(animated: true, completion: nil)
    }
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: ChecklistItem){
        print("Update")
        print("item text",item.text)
        let test = arrayCheckListItem.index(where:{ $0 === item })
        arrayCheckListItem[test!].text = item.text
        tableView.reloadData()
        controller.dismiss(animated: true, completion: nil)

    }

}

