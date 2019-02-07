import UIKit
extension UITableView {
    func reloadSectionWithoutAnimation(_ sectionIndex: Int) {
        UIView.setAnimationsEnabled(false)
        beginUpdates()
        let range = NSMakeRange(sectionIndex, 1)
        let sections = NSIndexSet(indexesIn: range)
        reloadSections(sections as IndexSet, with: .none)
        endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    func reloadData(withAnimation animation: UITableView.RowAnimation) {
        let range = NSMakeRange(0, numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        reloadSections(sections as IndexSet, with: animation)        
    }
}
