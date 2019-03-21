//
//  IconPickerViewController.swift
//  TodoList
//
//  Created by lpiem on 21/03/2019.
//  Copyright © 2019 lpiem.valentin. All rights reserved.
//

import UIKit

class IconPickerViewController: UITableViewController {
    
    var icons = [IconAsset]()
    var delegate : IconPickerViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        icons = IconAsset.allCases
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return icons.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.listDetailViewController(self, didChooseIcon: icons[indexPath.item])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imagePicker", for: indexPath)
        cell.textLabel?.text = icons[indexPath.item].rawValue
        cell.imageView?.image = icons[indexPath.item].image
        return cell
    }
}

protocol IconPickerViewDelegate : class{
    func listDetailViewController(_ controller: IconPickerViewController, didChooseIcon icon: IconAsset)

}
