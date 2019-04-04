
import Foundation



class CheckList : Codable {
    var name : String
    var item : [ChecklistItem]?
    var icon : IconAsset
    
    init(name:String, item:[ChecklistItem]?, icon:IconAsset=IconAsset.Chores){
        self.name = name
        self.item = item
        self.icon = icon
    }
    
    var uncheckedItemsCount : Int{
        get{
            return (item?.filter({ (ChecklistItem) -> Bool in
                ChecklistItem.checked
            }).count ?? 0)
        }
    }
}
