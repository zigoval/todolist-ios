//
//  ViewController.swift
//  TodoList
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ChecklistItem(text:"Finirlecoursd’iOS")
        ChecklistItem(text:"MettreàjourXCode",checked:true)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int{return 1}
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        cell.textLabel!.text = "WE ARE HERE TO STEAL YOUR BEER"
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

