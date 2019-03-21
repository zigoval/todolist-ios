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
    
    @IBAction func isTextHasChanged(_ sender: Any) {
        if((newList.text?.count)!>0)
        {
            btnDone.isEnabled=true
        }
    }
    
    var delegate : ListDetailViewControllerDelegate?
    var listToEdit : CheckList?
    @IBOutlet weak var selectedIcon: UILabel!
    
    var newIcon : IconAsset?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDone.isEnabled = false;
        if(listToEdit != nil){
            newList.text = listToEdit!.name
            self.title = "Edit List"
        }else{
            newIcon = IconAsset.Folder
        }
        selectedIcon.text = listToEdit?.icon.rawValue ?? newIcon?.rawValue
    }
    
    func iconHasBeenChanged(){
        if((newList.text?.count)!>0)
        {
            btnDone.isEnabled=true
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! IconPickerViewController
        destVC.delegate = self
    }
    
    @IBAction func done() {
        if(listToEdit != nil){
            listToEdit?.name = newList!.text!
            self.delegate?.listDetailViewController(self, didFinishEditingList: listToEdit!)
        }else{
            self.delegate?.listDetailViewController(self, didFinishAddingList: CheckList(name: newList.text!,item: (nil), icon : newIcon!))
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.newList.becomeFirstResponder()
        selectedIcon.text = listToEdit==nil ? newIcon!.rawValue : listToEdit?.icon.rawValue
    }
    
//    func textField(_ textField: UITextField,
//                   shouldChangeCharactersIn range: NSRange,
//                   replacementString string: String) -> Bool {
//        let nsString = textField.text as NSString?
//        let newString = nsString?.replacingCharacters(in: range, with: string)
//        if nsString?.isEqual(newString) ?? false && nsString?.isEqual(to: "") ?? false  {
//
//            btnDone.isEnabled=false
//            return true
//        } else {
//            btnDone.isEnabled=true
//            return false
//        }
//    }
    
    @IBAction func cancel() {
        self.delegate?.listDetailViewControllerDidCancel(self)
    }
    
}
protocol ListDetailViewControllerDelegate : class {
    func listDetailViewControllerDidCancel(_ controller: ListDetailViewController)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishAddingList item: CheckList)
    func listDetailViewController(_ controller: ListDetailViewController, didFinishEditingList item: CheckList)
}
extension ListDetailViewController : IconPickerViewDelegate {
    func listDetailViewController(_ controller: IconPickerViewController, didChooseIcon icon: IconAsset) {
        if(listToEdit == nil){
            newIcon = icon
        }else{
            listToEdit?.icon = icon
        }
        iconHasBeenChanged()
        navigationController?.popViewController(animated: true)
    }
}
