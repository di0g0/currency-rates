import UIKit
extension UINavigationBar {
    func configureForRevolut() {
        self.isTranslucent = false
        self.tintColor = .black
        self.barTintColor = .white
        self.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .medium)]
    }
}

