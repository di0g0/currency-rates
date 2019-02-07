import Foundation
extension Double {
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal        
        formatter.usesGroupingSeparator = false
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        guard let string = formatter.string(from: NSNumber(value: self)) else {
            return ""
        }
        
        return string
    }
}
