//
//  ChecklistItem.swift
//  TodoList
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class ChecklistItem : Codable{
    
    var text : String
    var checked : Bool
    var shouldRemind: Bool
    var dueDate : Date
    var itemID : Int?
    
    init(text:String, shouldRemind:Bool=false) {
        self.text = text
        self.checked = false
        self.shouldRemind = shouldRemind
        self.dueDate = Date()
    }
    init(text:String, checked:Bool, shouldRemind:Bool, dueDate:Date,itemID:Int){
        self.text = text
        self.checked = false
        self.shouldRemind = shouldRemind
        self.dueDate = Date()
        self.itemID = itemID
    }
    
    func toggleChecked(){
        self.checked = !checked
    }
    func toggleReminder(){
        self.shouldRemind = !shouldRemind
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
