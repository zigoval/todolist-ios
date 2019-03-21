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
    
    static var lists = [CheckList]()
    
//    init() {
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(DataModel.saveChecklists),
//            forName: UIApplication.didEnterBackgroundNotification,
//            object: nil)
//    }
    
    @objc static func saveChecklists(){
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
    
    static func loadChecklists(){
        print("is loading")
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: dataFileUrl)
            lists = try decoder.decode([CheckList].self, from: data)
        } catch {
            print(error)
        }
    }
    
    static var documentDirectory : URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    static var dataFileUrl : URL {
        return documentDirectory.appendingPathComponent("Checklists").appendingPathExtension("json")
    }
    
    static func sortChecklists(){
        lists = lists.sorted(by: { $0.name < $1.name })
    }
}
