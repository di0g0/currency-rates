import UIKit
import FlagKit
class CurrencyRateCell: UITableViewCell {
    static let identifier = "CurrencyRateCell"
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var rateTextField: UITextField!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func awakeFromNib() {
        selectionStyle = .none
        rateTextField.isUserInteractionEnabled = false
    }
    
    override func prepareForReuse() {
        rateTextField.isUserInteractionEnabled = false
        rateTextField.text = ""
    }
    
    func fill(with viewModel: CurrencyViewModel, inputDelegate: UITextFieldDelegate) {
        codeLabel.text = viewModel.currencyCode
        currencyNameLabel.text = viewModel.currencyName
        rateTextField.text = viewModel.formatedValue
        let flag = Flag(countryCode: viewModel.countryCode)
        flagImageView.image = flag?.image(style: .circle)
        rateTextField.delegate = inputDelegate
    }
    
    func fill(with viewModel: CurrencyViewModel) {
        codeLabel.text = viewModel.currencyCode
        currencyNameLabel.text = viewModel.currencyName
        rateTextField.text =  viewModel.formatedValue
        let flag = Flag(countryCode: viewModel.countryCode)
        flagImageView.image = flag?.image(style: .circle)
    }
    
    override func becomeFirstResponder() -> Bool {
        rateTextField.isUserInteractionEnabled = true
        return rateTextField.becomeFirstResponder()
    }
}
