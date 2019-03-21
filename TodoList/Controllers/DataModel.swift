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
            try data.write(to: AllListViewController.dataFileUrl)
            print(String(data: data, encoding: .utf8)!)
        } catch {
            print(error)
        }
    }
    
    static func loadChecklists(){
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
