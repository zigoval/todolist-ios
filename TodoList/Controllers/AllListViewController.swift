//
//  AllListViewController.swift
//  TodoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        DataModel.loadChecklists()
        DataModel.sortChecklists()    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            destVC.listToEdit = DataModel.lists[(tableView.indexPath(for: sender as! UITableViewCell)?.row)!]
            destVC.delegate = self
        } else
        {
            let destVC = segue.destination as! ChecklistViewController
            destVC.index = (tableView.indexPath(for: sender as! UITableViewCell)?.row)!
            destVC.arrayCheckListItem = DataModel.lists[(tableView.indexPath(for: sender as! UITableViewCell)?.row)!].item ?? [ChecklistItem]()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DataModel.lists.remove(at: indexPath.item)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForList", for: indexPath)
        cell.textLabel?.text = DataModel.lists[indexPath.item].name
        
        let doneTask = DataModel.lists[indexPath.item].uncheckedItemsCount
        let todoTask = DataModel.lists[indexPath.item].item?.count ?? -1
        let taskLeft = todoTask - doneTask
        switch  taskLeft{
        case 0:
            cell.detailTextLabel?.text =  "All Done !!"
        case -1:
            cell.detailTextLabel?.text =  "No Task"
        default:
            cell.detailTextLabel?.text = "Todo : " + String(doneTask) + "/" + String(todoTask)
        }
        cell.imageView?.image = DataModel.lists[indexPath.item].icon.image
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
extension AllListViewController : ListDetailViewControllerDelegate{
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController) {
        print("cancel")
        controller.dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingList item: CheckList) {
        print("Done")
        DataModel.lists.append(item)
        DataModel.sortChecklists()
        tableView.insertRows(at: [IndexPath(row: DataModel.lists.count-1, section: 0)], with: .automatic)
        controller.dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList item: CheckList) {
        print("Update")
        let test = DataModel.lists.index(where:{ $0 === item })
        DataModel.lists[test!].name = item.name
        DataModel.sortChecklists()
        tableView.reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
    
    
}
