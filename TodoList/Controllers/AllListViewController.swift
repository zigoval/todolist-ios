//
//  AllListViewController.swift
//  TodoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    
    //    var liste1 = CheckList(name: "Fr", item: [ChecklistItem(text:"Riri"),ChecklistItem(text:"Fifi"),ChecklistItem(text:"Loulou")])
    //    var liste2 = CheckList(name: "Eng", item: [ChecklistItem(text:"Huey"),ChecklistItem(text:"Dewey"),ChecklistItem(text:"Louie")])
    //    var liste3 = CheckList(name: "Jp", item: (nil))
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        TodoSingleton.loadChecklist()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static var documentDirectory : URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static var dataFileUrl : URL {
        return documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addList"
        {
            let navDestVC = segue.destination as! UINavigationController
            let destVC = navDestVC.topViewController as! ListDetailViewController
            destVC.delegate = self
        } else if segue.identifier == "editList"
        {
            let navDestVC = segue.destination as! UINavigationController
            let destVC = navDestVC.topViewController as! ListDetailViewController
            destVC.listToEdit = TodoSingleton.lists[(tableView.indexPath(for: sender as! UITableViewCell)?.row)!]
            destVC.delegate = self
        } else
        {
            let destVC = segue.destination as! ChecklistViewController
            destVC.index = (tableView.indexPath(for: sender as! UITableViewCell)?.row)!
            //let destVC = navDestVC.topViewController as! ChecklistViewController
            //destVC.list = TodoSingleton.lists[(tableView.indexPath(for: sender as! UITableViewCell)?.row)!]
            // destVC.delegate = self
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoSingleton.lists.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        TodoSingleton.lists.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        //TodoSingleton.saveChecklist()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForList", for: indexPath)
        cell.textLabel?.text = TodoSingleton.lists[indexPath.item].name
        return cell
    }
}
extension AllListViewController : ListDetailViewControllerDelegate{
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        print("cancel")
        controller.dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingList item: CheckList) {
        print("Done")
        TodoSingleton.lists.append(item)
        tableView.insertRows(at: [IndexPath(row: TodoSingleton.lists.count-1, section: 0)], with: .automatic)
        controller.dismiss(animated: true, completion: nil)
        //TodoSingleton.saveChecklist()
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList item: CheckList) {
        print("Update")
        let test = TodoSingleton.lists.index(where:{ $0 === item })
        TodoSingleton.lists[test!].name = item.name
        tableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
        //TodoSingleton.saveChecklist()
    }
    
    
}
