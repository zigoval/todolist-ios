//
//  AddItemTableViewController.swift
//  TodoList
//
//  Created by lpiem on 14/02/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class itemDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var newTodo: UITextField!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    var delegate : ItemDetailViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit != nil){
            newTodo.text = itemToEdit!.text
            self.title = "Edit Item"
        }
    }
    
    
    @IBAction func done() {
        if(itemToEdit != nil){
            itemToEdit?.text = newTodo!.text!
            self.delegate?.itemDetailViewController(self, didFinishEditingItem: itemToEdit!)
        }else{
            self.delegate?.itemDetailViewController(self, didFinishAddingItem: ChecklistItem(text: newTodo.text!))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.newTodo.becomeFirstResponder()
        self.newTodo.addTarget(self, action: #selector(textField(_:shouldChangeCharactersIn:replacementString:)), for: UIControl.Event.editingChanged)
        btnDone.isEnabled = false;
    }
    
    func textField(_ textField: UITextField,
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
        self.delegate?.itemDetailViewControllerDidCancel(self)
    }
    
}
protocol ItemDetailViewControllerDelegate : class {
    func itemDetailViewControllerDidCancel(_ controller: itemDetailViewController)
    func itemDetailViewController(_ controller: itemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(_ controller: itemDetailViewController, didFinishEditingItem item: ChecklistItem)
}
