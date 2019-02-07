import UIKit
enum TableSection: Int {
    case selectedCurrency = 0
    case conversion = 1
}

class CurrencyListViewController: UITableViewController {
    var selectedCurrency: CurrencyViewModel = Constants.CurrencyConversion.initialCurrencyViewModel {
        didSet {
            reloadAllSections()
        }
    }
    
    var currencies:[CurrencyViewModel] = [] {
        didSet {
            reloadConversionSection()
        }
    }
    var selectedValue:Double = Constants.CurrencyConversion.initialValue {
        didSet {
            reloadConversionSection()
        }
    }
    
    let conversionManager = ConversionManager(baseCurrency: Constants.CurrencyConversion.initialCurrencyViewModel)
    
    override func viewDidLoad() {
        self.title = Constants.CurrencyRateListTitle
        tableView.tableFooterView = UIView()
        conversionManager.startPollingRates()        
        conversionManager.onUpdateRates = { currencies in
            self.currencies = currencies
        }
    }
    
    deinit {
        conversionManager.cancelRequests()
    }
    
    func didSelectedCurrency(_ currency: CurrencyViewModel) {
        conversionManager.baseCurrency = currency
        selectedCurrency = currency
        selectedCurrency.value = selectedValue
        selectedValue = selectedCurrency.convertedValue
    }
    
    func reloadConversionSection() {
        tableView.reloadSectionWithoutAnimation(TableSection.conversion.rawValue)
    }
    
    func reloadAllSections() {
        tableView.reloadData(withAnimation: .top)
        let firstIndexPath = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: firstIndexPath, at: .top, animated: true)
        self.enableInputFor(indexPath: firstIndexPath)
    }
    
    func enableInputFor(indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath),
            cell.canBecomeFirstResponder {
            cell.becomeFirstResponder()
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension CurrencyListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else {
            return
        }
        switch section {
        case .selectedCurrency:
            break
        case .conversion:
            let currency = currencies[indexPath.row]
            didSelectedCurrency(currency)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableSection = TableSection(rawValue: section) else {
            return 0
        }
        switch tableSection {
        case .selectedCurrency:
            return 1
        case .conversion:
            return currencies.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = TableSection(rawValue: indexPath.section),
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyRateCell.identifier, for: indexPath) as? CurrencyRateCell else {
                return UITableViewCell()
        }
        switch section {
        case .selectedCurrency:
            var currency = selectedCurrency
            currency.value = selectedValue
            cell.fill(with: currency, inputDelegate: self)
        case .conversion:
            var currency = currencies[indexPath.row]
            currency.value = selectedValue
            cell.fill(with: currency)
        }
        
        return cell
    }
}

extension CurrencyListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text,
            let textRange = Range(range, in: text) else {
                return false
        }
        
        let updatedText = text.replacingCharacters(in: textRange, with: string)
            .replacingOccurrences(of: ",", with: ".")
        guard !updatedText.isEmpty else {
            self.selectedValue = 0
            return true
        }
        
        guard let value = Double(updatedText) else {
            return false
        }
        self.selectedValue =  value
        
        return true
    }
}
