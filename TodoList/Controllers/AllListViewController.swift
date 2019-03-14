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
        if segue.identifier == "addList"
        {
            let navDestVC = segue.destination as! UINavigationController
            let destVC = navDestVC.topViewController as! ListDetailViewController
            destVC.delegate = self
        } else if segue.identifier == "editList"
        {
            let navDestVC = segue.destination as! UINavigationController
            let destVC = navDestVC.topViewController as! ListDetailViewController
            destVC.listToEdit = lists[(tableView.indexPath(for: sender as! UITableViewCell)?.row)!]
            destVC.delegate = self
        }else{
            let destVC = segue.destination as! ChecklistViewController
            //let destVC = navDestVC.topViewController as! ChecklistViewController
            destVC.list = lists[(tableView.indexPath(for: sender as! UITableViewCell)?.row)!]
            // destVC.delegate = self
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        //saveChecklistItems()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForList", for: indexPath)
        cell.textLabel?.text = lists[indexPath.item].name
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
        lists.append(item)
        tableView.insertRows(at: [IndexPath(row: lists.count-1, section: 0)], with: .automatic)
        controller.dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList item: CheckList) {
        print("Update")
        let test = lists.index(where:{ $0 === item })
        lists[test!].name = item.name
        tableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
