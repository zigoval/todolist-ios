//
//  TodoSingleton.swift
//  TodoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import Foundation

class TodoSingleton {
    
    static var lists = [CheckList]()
    
    static func saveChecklist(){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(self.lists)
            try data.write(to: AllListViewController.dataFileUrl)
            print(String(data: data, encoding: .utf8)!)
        } catch {
            print(error)
        }
    }
    
    static func loadChecklist(){
        print("is loading")
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: AllListViewController.dataFileUrl)
            lists = try decoder.decode([CheckList].self, from: data)
        } catch {
            print(error)
        }
    }
}
