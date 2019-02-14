//
//  AddItemTableViewController.swift
//  TodoList
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var newTodo: UITextField!
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated:true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.newTodo.becomeFirstResponder()
        
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        if nsString?.isEqual(newString) ?? false  {
            return true
        } else {
            
            return false
        }
    }

    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true)
        
    }
}
protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
}
