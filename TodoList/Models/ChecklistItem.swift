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
    
    init(text:String, checked:Bool=false) {
        self.text = text
        self.checked = checked
    }
    
    func toggleChecked(){
        self.checked = !checked
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
