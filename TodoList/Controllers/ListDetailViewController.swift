//
//  ListDetailViewController.swift
//  TodoList
//
//  Created by lpiem on 14/03/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet weak var newList: UITextField!
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
    var delegate : ListDetailViewControllerDelegate?
    var listToEdit : CheckList?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(listToEdit != nil){
            newList.text = listToEdit!.name
            self.title = "Edit List"
        }
    }
    
    @IBAction func done() {
        if(listToEdit != nil){
            listToEdit?.name = newList!.text!
            self.delegate?.listDetailViewController(self, didFinishEditingList: listToEdit!)
        }else{
            self.delegate?.listDetailViewController(self, didFinishAddingList: CheckList(name: newList.text!,item: (nil)))
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.newList.becomeFirstResponder()
        self.newList.addTarget(self, action: #selector(textField(_:shouldChangeCharactersIn:replacementString:)), for: UIControl.Event.editingChanged)
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
        self.delegate?.listDetailViewControllerDidCancel(self)
    }
    
}
protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingList item: CheckList)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList item: CheckList)
}
