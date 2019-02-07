enum Currency {
    case euro
    case real
    case dollar
    case pounds
    case australianDollar
    case yen
    case lev
    case krw
    case turkishLira
    case php
    case forint
    case litas
    case yuan
    case czech
    case danish
    case hongKong
    case croatian
    case indonesian
    case israel
    case indian
    case mexican
    case iceland
    case malasian
    case norwegian
    case newZealand
    case poland
    case southAfrican
    case thai
    case singapore
    case swedish
    case russia
    case romenian
    
    static let allCurrencies:[Currency] = [ .euro,
                                            .real,
                                            .dollar,
                                            .pounds,
                                            .australianDollar,
                                            .yen,
                                            .lev,
                                            .krw,
                                            .turkishLira,
                                            .php,
                                            .forint,
                                            .litas,
                                            .yuan,
                                            .czech,
                                            .danish,
                                            .hongKong,
                                            .croatian,
                                            .indonesian,
                                            .israel,
                                            .indian,
                                            .mexican,
                                            .iceland,
                                            .malasian,
                                            .norwegian,
                                            .newZealand,
                                            .poland,
                                            .southAfrican,
                                            .thai,
                                            .singapore,
                                            .swedish,
                                            .russia,
                                            .romenian
        
    ]
    
    var name: String {
        switch self {
        case .euro:
            return "Euro"
        case .real:
            return "Brazilian Real"
        case .dollar:
            return "US Dollar"
        case .australianDollar:
            return "Australian Dollar"
        case .yen:
            return "Japanese Yen"
        case .lev:
            return "Bulgarian Lev"
        case .krw:
            return "South Korean Won"
        case .turkishLira:
            return "Turkish Lira"
        case .php:
            return "Philipine Peso"
        case .forint:
            return "Hungarian Forint"
        case .litas:
            return "Lithuanian Litas"
        case .yuan:
            return "Yuan Renminbi"
        case .czech:
            return "Czech Koruna"
        case .danish:
            return "Danish Krone"
        case .pounds:
            return "Pound Sterling"
        case .hongKong:
            return "Hong Kong Dollar"
        case .croatian:
            return "Croatian Kuna"
        case .indonesian:
            return "Indonesian Rupiah"
        case .israel:
            return "New Israeli Sheqel"
        case .indian:
            return "Indian Rupee"
        case .mexican:
            return "Mexican Peso"
        case .iceland:
            return "Iceland Krona"
        case .malasian:
            return "Malaysian Ringgit"
        case .norwegian:
            return "Norwegian Krone"
        case .newZealand:
            return "New Zealand Dollar"
        case .poland:
            return "Poland Zloty"
        case .southAfrican:
            return "South African Rand"
        case .thai:
            return "Thai Baht"
        case .singapore:
            return "Singapore Dollar"
        case .swedish:
            return "Swedish Krona"
        case .russia:
            return "Russian Ruble"
        case .romenian:
            return "Romanian leu"
        }
    }
    
    var code: String {
        switch self {
        case .euro:
            return "EUR"
        case .real:
            return "BRL"
        case .dollar:
            return "USD"
        case .yen:
            return "JPY"
        case .australianDollar:
            return "CAD"
        case .lev:
            return "BGN"
        case .krw:
            return "KRW"
        case .turkishLira:
            return "TRY"
        case .php:
            return "PHP"
        case .forint:
            return "HUF"
        case .litas:
            return "CHF"
        case .yuan:
            return "CNY"
        case .czech:
            return "CZK"
        case .danish:
            return "DKK"
        case .pounds:
            return "GBP"
        case .hongKong:
            return "HKD"
        case .croatian:
            return "HRK"
        case .indonesian:
            return "IDR"
        case .israel:
            return "ILS"
        case .indian:
            return "INR"
        case .mexican:
            return "MXN"
        case .iceland:
            return "ISK"
        case .malasian:
            return "MYR"
        case .norwegian:
            return "NOK"
        case .newZealand:
            return "NZD"
        case .poland:
            return "PLN"
        case .romenian:
            return "RON"
        case .russia:
            return "RUB"
        case .swedish:
            return "SEK"
        case .singapore:
            return "SGD"
        case .thai:
            return "THB"
        case .southAfrican:
            return "ZAR"
        }
    }
}
