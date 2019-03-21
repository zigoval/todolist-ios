
import Foundation



class CheckList : Codable {
    var name : String
    var item : [ChecklistItem]?
    
    init(name:String, item:[ChecklistItem]?){
        self.name = name
        self.item = item
    }
    
    var uncheckedItemsCount : Int{
        get{
            return (item?.filter({ (ChecklistItem) -> Bool in
                ChecklistItem.checked
            }).count)!
        }
    
    }
}
