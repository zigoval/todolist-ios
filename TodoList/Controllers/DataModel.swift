//
//  TodoSingleton.swift
//  TodoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import Foundation
import UIKit

class DataModel {
    
    static let shared = DataModel()
    let FIRST_LAUCH="firstLaunch";
    
    var lists = [CheckList]()
    var fakeCheckListItem = [ChecklistItem]()
    
    init(){
        UserDefaults.standard.register(defaults: [FIRST_LAUCH:true])
        let firstLaunch = UserDefaults.standard.bool(forKey: FIRST_LAUCH)
        if firstLaunch  {
            self.initCheckList()
            UserDefaults.standard.set(false, forKey: FIRST_LAUCH)
        } else {
            self.loadCheckLists()
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(saveCheckLists),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil)
    }
    
    func initCheckList(){
        self.fakeCheckListItem.append(ChecklistItem(text: "Edit you first item"))
        self.fakeCheckListItem.append(ChecklistItem(text: "Swipe me to delete"))
        self.lists.append(CheckList(name: "List", item: fakeCheckListItem))
    }
    
    func loadCheckLists(){
        if(FileManager.default.fileExists(atPath:self.dataFileUrl.path)){
            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: dataFileUrl)
                lists = try decoder.decode([CheckList].self, from: data)
            } catch {
                print(error)
            }
        }else{
            self.initCheckList()
        }
        
    }
    
    @objc func saveCheckLists(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(self.lists)
            try data.write(to: dataFileUrl)
            print(String(data: data, encoding: .utf8)!)
        } catch {
            print(error)
        }
    }
    
    private var documentDirectory : URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private var dataFileUrl : URL {
        return documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
    }
    
    func sortChecklists(){
        lists = lists.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
    }
    
    
}
