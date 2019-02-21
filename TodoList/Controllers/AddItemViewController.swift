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
    @IBOutlet weak var btnDone: UIBarButtonItem!
    var delegate : AddItemViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit != nil){
            newTodo.text = itemToEdit!.text
            self.title = "Edit Item"
        }else{
            print("in else")
        }
    }
    
    
    @IBAction func done() {
        print("je suis dans le done")
        if(itemToEdit != nil){
            itemToEdit?.text = newTodo!.text!
            self.delegate?.addItemViewController(self, didFinishEditingItem: itemToEdit!)
        }else{
            self.delegate?.addItemViewController(self, didFinishAddingItem: ChecklistItem(text: newTodo.text!))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.newTodo.becomeFirstResponder()
        self.newTodo.addTarget(self, action: #selector(textField(_:shouldChangeCharactersIn:replacementString:)), for: UIControl.Event.editingChanged)
        btnDone.isEnabled = false;
    }
    
    @objc func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let nsString = textField.text as NSString?
        let newString = nsString?.replacingCharacters(in: range, with: string)
        if nsString?.isEqual(newString) ?? false && nsString?.isEqual(to: "") ?? false  {
            btnDone.isEnabled=false
            return true
        } else {
            btnDone.isEnabled=true
            return false
        }
    }

    
    @IBAction func cancel() {
        print("je suis dans le cancel")
        self.delegate?.addItemViewControllerDidCancel(self)

        
    }
}
protocol AddItemViewControllerDelegate : class {
    func addItemViewControllerDidCancel(_ controller: AddItemViewController)
    func addItemViewController(_ controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
    func addItemViewController(_ controller: AddItemViewController, didFinishEditingItem item: ChecklistItem)
}
