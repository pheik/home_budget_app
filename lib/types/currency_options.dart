import 'dart:ui';

import '../l10n/app_localizations.dart';

/// Class for defining a currency option.
class CurrencyOption {

  final String code;
  final Map<String, String> localizations;
  final int decimals;

  /// Defines a currency option.
  CurrencyOption({
    required this.code,
    required this.localizations,
    required this.decimals
  });

  /// Returns the name of the currency in the given language.
  ///
  /// If the [languageCode] is not given, returns the name of the currency in
  /// the language defined by the default locale.
  String? getName(String? languageCode) {
    if(languageCode != null) {
      return localizations[languageCode];
    }
    else {
      Locale defaultLocale = AppLocalizations.supportedLocales.first;
      return localizations[defaultLocale.languageCode];
    }
  }

}

/// Utility class for handling currency options.
class CurrencyUtility {

  /// List of all available currencies.
  static final Map<String, CurrencyOption> _currencyOptions = {
    "AED": CurrencyOption(
      code: "AED",
      localizations: <String, String>{
        "en": "United Arab Emirates dirham",
        "fi": "Yhdistyneiden arabiemiirikuntien dirhami"
      },
      decimals: 2
    ),
    "AFN": CurrencyOption(
      code: "AFN",
      localizations: <String, String>{
        "en": "Afghan afghani",
        "fi": "Afganistanin afgaani"
      },
      decimals: 2
    ),
    "ALL": CurrencyOption(
        code: "ALL",
        localizations: <String, String>{
          "en": "Albanian lek",
          "fi": "Albanian lek"
        },
        decimals: 2
    ),
    "AMD": CurrencyOption(
        code: "AMD",
        localizations: <String, String>{
          "en": "Armenian dram",
          "fi": "Armenian dram"
        },
        decimals: 2
    ),
    "AND": CurrencyOption(
        code: "AND",
        localizations: <String, String>{
          "en": "Netherlands Antillean guilder",
          "fi": "Alankomaiden Antillien guldeni"
        },
        decimals: 2
    ),
    "AOA": CurrencyOption(
        code: "AOA",
        localizations: <String, String>{
          "en": "Angolan kwanza",
          "fi": "Angolan kwanza"
        },
        decimals: 2
    ),
    "ARS": CurrencyOption(
        code: "ARS",
        localizations: <String, String>{
          "en": "Argentine peso",
          "fi": "Argentiinan peso"
        },
        decimals: 2
    ),
    "AUD": CurrencyOption(
        code: "AUD",
        localizations: <String, String>{
          "en": "Australian dollar",
          "fi": "Australian dollari"
        },
        decimals: 2
    ),
    "AWG": CurrencyOption(
        code: "AWG",
        localizations: <String, String>{
          "en": "Aruban florin",
          "fi": "Aruban floriini"
        },
        decimals: 2
    ),
    "AZN": CurrencyOption(
        code: "AZN",
        localizations: <String, String>{
          "en": "Azerbaijani manat",
          "fi": "Azerbaidžanin manat"
        },
        decimals: 2
    ),
    "BAM": CurrencyOption(
        code: "BAM",
        localizations: <String, String>{
          "en": "Bosnia and Herzegovina convertible mark",
          "fi": "Bosnian ja Hertsegovinan vaihdettava markka"
        },
        decimals: 2
    ),
    "BBD": CurrencyOption(
        code: "BBD",
        localizations: <String, String>{
          "en": "Barbados dollar",
          "fi": "Barbadoksen dollarir"
        },
        decimals: 2
    ),
    "BDT": CurrencyOption(
        code: "BDT",
        localizations: <String, String>{
          "en": "Bangladeshi taka",
          "fi": "Bangladeshin taka"
        },
        decimals: 2
    ),
    "BGN": CurrencyOption(
        code: "BGN",
        localizations: <String, String>{
          "en": "Bulgarian lev",
          "fi": "Bulgarian lev"
        },
        decimals: 2
    ),
    "BHD": CurrencyOption(
        code: "BHD",
        localizations: <String, String>{
          "en": "Bahraini dinar",
          "fi": "Bahrainin dinaari"
        },
        decimals: 3
    ),
    "BIF": CurrencyOption(
        code: "BIF",
        localizations: <String, String>{
          "en": "Burundian franc",
          "fi": "Burundin frangi"
        },
        decimals: 0
    ),
    "BMD": CurrencyOption(
        code: "BMD",
        localizations: <String, String>{
          "en": "Bermudian dollar",
          "fi": "Bermudan dollari"
        },
        decimals: 2
    ),
    "BND": CurrencyOption(
        code: "BND",
        localizations: <String, String>{
          "en": "Brunei dollar",
          "fi": "Brunein dollari"
        },
        decimals: 2
    ),
    "BOB": CurrencyOption(
        code: "BOB",
        localizations: <String, String>{
          "en": "Bolivian boliviano",
          "fi": "Bolivian boliviano"
        },
        decimals: 2
    ),
    "BRL": CurrencyOption(
        code: "BRL",
        localizations: <String, String>{
          "en": "Brazilian real",
          "fi": "Brasilian real"
        },
        decimals: 2
    ),
    "BSD": CurrencyOption(
        code: "BSD",
        localizations: <String, String>{
          "en": "Bahamian dollar",
          "fi": "Bahaman dollari"
        },
        decimals: 2
    ),
    "BTN": CurrencyOption(
        code: "BTN",
        localizations: <String, String>{
          "en": "Bhutanese ngultrum",
          "fi": "Bhutanin ngultrum"
        },
        decimals: 2
    ),
    "BWP": CurrencyOption(
        code: "BTN",
        localizations: <String, String>{
          "en": "Botswana pula",
          "fi": "Botswanan pula"
        },
        decimals: 2
    ),
    "BYN": CurrencyOption(
        code: "BYN",
        localizations: <String, String>{
          "en": "Belarusian ruble",
          "fi": "Valko-Venäjän rupla"
        },
        decimals: 0
    ),
    "BZD": CurrencyOption(
        code: "BZD",
        localizations: <String, String>{
          "en": "Belize dollar",
          "fi": "Belizen dollari"
        },
        decimals: 2
    ),
    "CAD": CurrencyOption(
        code: "CAD",
        localizations: <String, String>{
          "en": "Canadian dollar",
          "fi": "Kanadan dollari"
        },
        decimals: 2
    ),
    "CDF": CurrencyOption(
        code: "CDF",
        localizations: <String, String>{
          "en": "Congolese franc",
          "fi": "Kongon frangi"
        },
        decimals: 2
    ),
    "CHF": CurrencyOption(
        code: "CHF",
        localizations: <String, String>{
          "en": "Swiss franc",
          "fi": "Sveitsin frangi"
        },
        decimals: 2
    ),
    "CLP": CurrencyOption(
        code: "CLP",
        localizations: <String, String>{
          "en": "Chilean peso",
          "fi": "Chilen peso"
        },
        decimals: 0
    ),
    "CNY": CurrencyOption(
        code: "CNY",
        localizations: <String, String>{
          "en": "Renminbi",
          "fi": "Kiinan renmimbi (yuan)"
        },
        decimals: 2
    ),
    "COP": CurrencyOption(
        code: "COP",
        localizations: <String, String>{
          "en": "Colombian peso",
          "fi": "Kolumbian peso"
        },
        decimals: 2
    ),
    "CRC": CurrencyOption(
        code: "CRC",
        localizations: <String, String>{
          "en": "Costa Rican colon",
          "fi": "Costa Rican colón"
        },
        decimals: 2
    ),
    "CUP": CurrencyOption(
        code: "CUP",
        localizations: <String, String>{
          "en": "Cuban peso",
          "fi": "Kuuban peso"
        },
        decimals: 2
    ),
    "CVE": CurrencyOption(
        code: "CVE",
        localizations: <String, String>{
          "en": "Cape Verdean escudo",
          "fi": "Kap Verden escudo"
        },
        decimals: 0
    ),
    "CZK": CurrencyOption(
        code: "CZK",
        localizations: <String, String>{
          "en": "Czech koruna",
          "fi": "Tšekin koruna"
        },
        decimals: 2
    ),
    "DJF": CurrencyOption(
        code: "DJF",
        localizations: <String, String>{
          "en": "Djiboutian franc",
          "fi": "Djiboutin frangi"
        },
        decimals: 0
    ),
    "DKK": CurrencyOption(
        code: "DKK",
        localizations: <String, String>{
          "en": "Danish krone",
          "fi": "Tanskan kruunu"
        },
        decimals: 2
    ),
    "DOP": CurrencyOption(
        code: "DOP",
        localizations: <String, String>{
          "en": "Dominican peso",
          "fi": "Dominikaanisen tasavallan peso"
        },
        decimals: 2
    ),
    "DZD": CurrencyOption(
        code: "DZD",
        localizations: <String, String>{
          "en": "Algerian dinar",
          "fi": "Algerian dinaari"
        },
        decimals: 2
    ),
    "EGP": CurrencyOption(
        code: "EGP",
        localizations: <String, String>{
          "en": "Egyptian pound",
          "fi": "Egyptin punta"
        },
        decimals: 2
    ),
    "ERN": CurrencyOption(
        code: "ERN",
        localizations: <String, String>{
          "en": "Eritrean nakfa",
          "fi": "Eritrean nakfa"
        },
        decimals: 2
    ),
    "ETB": CurrencyOption(
        code: "ETB",
        localizations: <String, String>{
          "en": "Ethiopian birr",
          "fi": "Etiopian birr"
        },
        decimals: 2
    ),
    "EUR": CurrencyOption(
        code: "EUR",
        localizations: <String, String>{
          "en": "Euro",
          "fi": "Euro"
        },
        decimals: 2
    ),
    "FJD": CurrencyOption(
        code: "FJD",
        localizations: <String, String>{
          "en": "Fiji dollar",
          "fi": "Fidžin dollari"
        },
        decimals: 2
    ),
    "FKP": CurrencyOption(
        code: "FKP",
        localizations: <String, String>{
          "en": "Falkland Islands pound",
          "fi": "Falklandin punta"
        },
        decimals: 2
    ),
    "GBP": CurrencyOption(
        code: "GBP",
        localizations: <String, String>{
          "en": "Pound sterling",
          "fi": "Englannin punta"
        },
        decimals: 2
    ),
    "GEL": CurrencyOption(
        code: "GEL",
        localizations: <String, String>{
          "en": "Georgian lari",
          "fi": "Georgian lari"
        },
        decimals: 2
    ),
    "GHS": CurrencyOption(
        code: "GHS",
        localizations: <String, String>{
          "en": "Ghanaian cedi",
          "fi": "Ghanan cedi"
        },
        decimals: 2
    ),
    "GIP": CurrencyOption(
        code: "GIP",
        localizations: <String, String>{
          "en": "Gibraltar pound",
          "fi": "Gibraltarin punta"
        },
        decimals: 2
    ),
    "GMD": CurrencyOption(
        code: "GMD",
        localizations: <String, String>{
          "en": "Gambian dalasi",
          "fi": "Gambian dalasi"
        },
        decimals: 2
    ),
    "GNF": CurrencyOption(
        code: "GNF",
        localizations: <String, String>{
          "en": "Guinean franc",
          "fi": "Guinean frangi"
        },
        decimals: 0
    ),
    "GTQ": CurrencyOption(
        code: "GTQ",
        localizations: <String, String>{
          "en": "Guatemalan quetzal",
          "fi": "Guatemalan quetzal"
        },
        decimals: 2
    ),
    "GYD": CurrencyOption(
        code: "GYD",
        localizations: <String, String>{
          "en": "Guyanese dollar",
          "fi": "Guyanan dollari"
        },
        decimals: 2
    ),
    "HKD": CurrencyOption(
        code: "HKD",
        localizations: <String, String>{
          "en": "Hong Kong dollar",
          "fi": "Hongkongin dollari"
        },
        decimals: 2
    ),
    "HNL": CurrencyOption(
        code: "HNL",
        localizations: <String, String>{
          "en": "Honduran lempira",
          "fi": "Hondurasin lempira"
        },
        decimals: 2
    ),
    "HTG": CurrencyOption(
        code: "HTG",
        localizations: <String, String>{
          "en": "Haitian gourde",
          "fi": "Haitin gourde"
        },
        decimals: 2
    ),
    "HUF": CurrencyOption(
        code: "HUF",
        localizations: <String, String>{
          "en": "Hungarian forint",
          "fi": "Unkarin forintti"
        },
        decimals: 2
    ),
    "IDR": CurrencyOption(
        code: "IDR",
        localizations: <String, String>{
          "en": "Indonesian rupiah",
          "fi": "Indonesian rupia"
        },
        decimals: 0
    ),
    "ILS": CurrencyOption(
        code: "ILS",
        localizations: <String, String>{
          "en": "Israeli new shekel",
          "fi": "Uusi Israelin sekeli"
        },
        decimals: 2
    ),
    "INR": CurrencyOption(
        code: "INR",
        localizations: <String, String>{
          "en": "Indian rupee",
          "fi": "Intian rupia"
        },
        decimals: 2
    ),
    "IQD": CurrencyOption(
        code: "IQD",
        localizations: <String, String>{
          "en": "Iraqi dinar",
          "fi": "Irakin dinaari"
        },
        decimals: 3
    ),
    "IRR": CurrencyOption(
        code: "IRR",
        localizations: <String, String>{
          "en": "Iranian rial",
          "fi": "Iranin rial"
        },
        decimals: 0
    ),
    "ISK": CurrencyOption(
        code: "ISK",
        localizations: <String, String>{
          "en": "Icelandic króna",
          "fi": "Islannin kruunu"
        },
        decimals: 0
    ),
    "JMD": CurrencyOption(
        code: "JMD",
        localizations: <String, String>{
          "en": "Jamaican dollar",
          "fi": "Jamaikan dollari"
        },
        decimals: 2
    ),
    "JOD": CurrencyOption(
        code: "JOD",
        localizations: <String, String>{
          "en": "Jordanian dinar",
          "fi": "Jordanian dinaari"
        },
        decimals: 3
    ),
    "JPY": CurrencyOption(
        code: "JPY",
        localizations: <String, String>{
          "en": "Japanese yen",
          "fi": "Japanin jeni"
        },
        decimals: 0
    ),
    "KES": CurrencyOption(
        code: "KES",
        localizations: <String, String>{
          "en": "Kenyan shilling",
          "fi": "Kenian šillinki"
        },
        decimals: 2
    ),
    "KGS": CurrencyOption(
        code: "KGS",
        localizations: <String, String>{
          "en": "Kyrgyzstani som",
          "fi": "Kirgisian som"
        },
        decimals: 2
    ),
    "KHR": CurrencyOption(
        code: "KHR",
        localizations: <String, String>{
          "en": "Cambodian riel",
          "fi": "Kambodžan riel"
        },
        decimals: 0
    ),
    "KMF": CurrencyOption(
        code: "KMF",
        localizations: <String, String>{
          "en": "Comoro franc",
          "fi": "Komorien frangi"
        },
        decimals: 0
    ),
    "KPW": CurrencyOption(
        code: "KPW",
        localizations: <String, String>{
          "en": "North Korean won",
          "fi": "Pohjois-Korean won"
        },
        decimals: 0
    ),
    "KRW": CurrencyOption(
        code: "KRW",
        localizations: <String, String>{
          "en": "South Korean won",
          "fi": "Etelä-Korean won"
        },
        decimals: 0
    ),
    "KWD": CurrencyOption(
        code: "KWD",
        localizations: <String, String>{
          "en": "Kuwaiti dinar",
          "fi": "Kuwaitin dinaari"
        },
        decimals: 3
    ),
    "KYD": CurrencyOption(
        code: "KYD",
        localizations: <String, String>{
          "en": "Cayman Islands dollar",
          "fi": "Caymansaarten dollari"
        },
        decimals: 2
    ),
    "KZT": CurrencyOption(
        code: "KZT",
        localizations: <String, String>{
          "en": "Kazakhstani tenge",
          "fi": "Kazakstanin tenge"
        },
        decimals: 2
    ),
    "LAK": CurrencyOption(
        code: "LAK",
        localizations: <String, String>{
          "en": "Lao kip",
          "fi": "Laosin kip"
        },
        decimals: 0
    ),
    "LBP": CurrencyOption(
        code: "LBP",
        localizations: <String, String>{
          "en": "Lebanese pound",
          "fi": "Libanonin punta"
        },
        decimals: 0
    ),
    "LKR": CurrencyOption(
        code: "LKR",
        localizations: <String, String>{
          "en": "Sri Lankan rupee",
          "fi": "Sri Lankan rupia"
        },
        decimals: 2
    ),
    "LRD": CurrencyOption(
        code: "LRD",
        localizations: <String, String>{
          "en": "Liberian dollar",
          "fi": "Liberian dollari"
        },
        decimals: 2
    ),
    "LSL": CurrencyOption(
        code: "LSL",
        localizations: <String, String>{
          "en": "Lesotho loti",
          "fi": "Lesothon loti"
        },
        decimals: 2
    ),
    "LYD": CurrencyOption(
        code: "LYD",
        localizations: <String, String>{
          "en": "Libyan dinar",
          "fi": "Libyan dinaari"
        },
        decimals: 3
    ),
    "MAD": CurrencyOption(
        code: "MAD",
        localizations: <String, String>{
          "en": "Moroccan dirham",
          "fi": "Marokon dirhami"
        },
        decimals: 2
    ),
    "MDL": CurrencyOption(
        code: "MDL",
        localizations: <String, String>{
          "en": "Moldovan leu",
          "fi": "Moldovan leu"
        },
        decimals: 2
    ),
    "MGA": CurrencyOption(
        code: "MGA",
        localizations: <String, String>{
          "en": "Malagasy ariary",
          "fi": "Madagaskarin ariary"
        },
        decimals: 0
    ),
    "MKD": CurrencyOption(
        code: "MKD",
        localizations: <String, String>{
          "en": "Macedonian denar",
          "fi": "Makedonian denaari"
        },
        decimals: 2
    ),
    "MMK": CurrencyOption(
        code: "MMK",
        localizations: <String, String>{
          "en": "Myanmar kyat",
          "fi": "Myanmarin kyat"
        },
        decimals: 0
    ),
    "MNT": CurrencyOption(
        code: "MNT",
        localizations: <String, String>{
          "en": "Mongolian tögrög",
          "fi": "Mongolian tugrik"
        },
        decimals: 2
    ),
    "MOP": CurrencyOption(
        code: "MOP",
        localizations: <String, String>{
          "en": "Macanese pataca",
          "fi": "Macaon pataca"
        },
        decimals: 1
    ),
    "MRU": CurrencyOption(
        code: "MRU",
        localizations: <String, String>{
          "en": "Mauritanian ouguiya",
          "fi": "Mauritanian ouguiya"
        },
        decimals: 0
    ),
    "MUR": CurrencyOption(
        code: "MUR",
        localizations: <String, String>{
          "en": "Mauritian rupee",
          "fi": "Mauritiuksen rupia"
        },
        decimals: 2
    ),
    "MVR": CurrencyOption(
        code: "MVR",
        localizations: <String, String>{
          "en": "Maldivian rufiyaa",
          "fi": "Malediivien rufiyaa"
        },
        decimals: 2
    ),
    "MWK": CurrencyOption(
        code: "MWK",
        localizations: <String, String>{
          "en": "Malawian kwacha",
          "fi": "Malawin kwacha"
        },
        decimals: 2
    ),
    "MXN": CurrencyOption(
        code: "MXN",
        localizations: <String, String>{
          "en": "Mexican peso",
          "fi": "Meksikon peso"
        },
        decimals: 2
    ),
    "MYR": CurrencyOption(
        code: "MYR",
        localizations: <String, String>{
          "en": "Malaysian ringgit",
          "fi": "Malesian ringgit"
        },
        decimals: 2
    ),
    "MZN": CurrencyOption(
        code: "MZN",
        localizations: <String, String>{
          "en": "Mozambican metical",
          "fi": "Mosambikin metical"
        },
        decimals: 2
    ),
    "NAD": CurrencyOption(
        code: "NAD",
        localizations: <String, String>{
          "en": "Namibian dollar",
          "fi": "Namibian dollari"
        },
        decimals: 2
    ),
    "NGN": CurrencyOption(
        code: "NGN",
        localizations: <String, String>{
          "en": "Nigerian naira",
          "fi": "Nigerian naira"
        },
        decimals: 2
    ),
    "NIO": CurrencyOption(
        code: "NIO",
        localizations: <String, String>{
          "en": "Nicaraguan córdoba",
          "fi": "Nicaraguan córdoba"
        },
        decimals: 2
    ),
    "NOK": CurrencyOption(
        code: "NOK",
        localizations: <String, String>{
          "en": "Norwegian krone",
          "fi": "Norjan kruunu"
        },
        decimals: 2
    ),
    "NPR": CurrencyOption(
        code: "NPR",
        localizations: <String, String>{
          "en": "Nepalese rupee",
          "fi": "Nepalin rupia"
        },
        decimals: 2
    ),
    "NZD": CurrencyOption(
        code: "NZD",
        localizations: <String, String>{
          "en": "New Zealand dollar",
          "fi": "Uuden-Seelannin dollari"
        },
        decimals: 2
    ),
    "OMR": CurrencyOption(
        code: "OMR",
        localizations: <String, String>{
          "en": "Omani rial",
          "fi": "Omanin rial"
        },
        decimals: 3
    ),
    "PAB": CurrencyOption(
        code: "PAB",
        localizations: <String, String>{
          "en": "Panamanian balboa",
          "fi": "Panaman balboa"
        },
        decimals: 2
    ),
    "PEN": CurrencyOption(
        code: "PEN",
        localizations: <String, String>{
          "en": "Peruvian sol",
          "fi": "Perun sol"
        },
        decimals: 2
    ),
    "PGK": CurrencyOption(
        code: "PGK",
        localizations: <String, String>{
          "en": "Papua New Guinean kina",
          "fi": "Papua-Uuden-Guinean kina"
        },
        decimals: 2
    ),
    "PHP": CurrencyOption(
        code: "PHP",
        localizations: <String, String>{
          "en": "Philippine peso",
          "fi": "Filippiinien peso"
        },
        decimals: 2
    ),
    "PKR": CurrencyOption(
        code: "PKR",
        localizations: <String, String>{
          "en": "Pakistani rupee",
          "fi": "Pakistanin rupia"
        },
        decimals: 2
    ),
    "PLN": CurrencyOption(
        code: "PLN",
        localizations: <String, String>{
          "en": "Polish złoty",
          "fi": "Puolan złoty"
        },
        decimals: 2
    ),
    "PYG": CurrencyOption(
        code: "PYG",
        localizations: <String, String>{
          "en": "Paraguayan guaraní",
          "fi": "Paraguayn guaraní"
        },
        decimals: 0
    ),
    "QAR": CurrencyOption(
        code: "QAR",
        localizations: <String, String>{
          "en": "Qatari riyal",
          "fi": "Qatarin rial"
        },
        decimals: 2
    ),
    "RON": CurrencyOption(
        code: "RON",
        localizations: <String, String>{
          "en": "Romanian leu",
          "fi": "Romanian leu"
        },
        decimals: 2
    ),
    "RSD": CurrencyOption(
        code: "RSD",
        localizations: <String, String>{
          "en": "Serbian dinar",
          "fi": "Serbian dinaari"
        },
        decimals: 2
    ),
    "RUB": CurrencyOption(
        code: "RUB",
        localizations: <String, String>{
          "en": "Russian ruble",
          "fi": "Venäjän rupla"
        },
        decimals: 2
    ),
    "RWF": CurrencyOption(
        code: "RWF",
        localizations: <String, String>{
          "en": "Rwandan franc",
          "fi": "Ruandan frangi"
        },
        decimals: 0
    ),
    "SAR": CurrencyOption(
        code: "SAR",
        localizations: <String, String>{
          "en": "Saudi riyal",
          "fi": "Saudi-Arabian rial"
        },
        decimals: 2
    ),
    "SBD": CurrencyOption(
        code: "SBD",
        localizations: <String, String>{
          "en": "Solomon Islands dollar",
          "fi": "Salomonsaarten dollari"
        },
        decimals: 2
    ),
    "SCR": CurrencyOption(
        code: "SCR",
        localizations: <String, String>{
          "en": "Seychelles rupee",
          "fi": "Seychellien rupia"
        },
        decimals: 2
    ),
    "SDG": CurrencyOption(
        code: "SDG",
        localizations: <String, String>{
          "en": "Sudanese pound",
          "fi": "Sudanin punta"
        },
        decimals: 2
    ),
    "SEK": CurrencyOption(
        code: "SEK",
        localizations: <String, String>{
          "en": "Swedish krona",
          "fi": "Ruotsin kruunu"
        },
        decimals: 2
    ),
    "SGD": CurrencyOption(
        code: "SGD",
        localizations: <String, String>{
          "en": "Singapore dollar",
          "fi": "Singaporen dollari"
        },
        decimals: 2
    ),
    "SHP": CurrencyOption(
        code: "SHP",
        localizations: <String, String>{
          "en": "Saint Helena pound",
          "fi": "Saint Helenan punta"
        },
        decimals: 2
    ),
    "SLE": CurrencyOption(
        code: "SLE",
        localizations: <String, String>{
          "en": "Sierra Leonean leone",
          "fi": "Sierra Leonen leone"
        },
        decimals: 2
    ),
    "SOS": CurrencyOption(
        code: "SOS",
        localizations: <String, String>{
          "en": "Somali shilling",
          "fi": "Somalian šillinki"
        },
        decimals: 2
    ),
    "SRD": CurrencyOption(
        code: "SRD",
        localizations: <String, String>{
          "en": "Surinamese dollar",
          "fi": "Surinamen dollari"
        },
        decimals: 2
    ),
    "SSP": CurrencyOption(
        code: "SSP",
        localizations: <String, String>{
          "en": "South Sudanese pound",
          "fi": "Etelä-Sudanin punta"
        },
        decimals: 2
    ),
    "STN": CurrencyOption(
        code: "STN",
        localizations: <String, String>{
          "en": "São Tomé and Príncipe dobra",
          "fi": "São Tomén ja Príncipen dobra"
        },
        decimals: 0
    ),
    "SYP": CurrencyOption(
        code: "SYP",
        localizations: <String, String>{
          "en": "Syrian pound",
          "fi": "Syyrian punta"
        },
        decimals: 2
    ),
    "SZL": CurrencyOption(
        code: "SZL",
        localizations: <String, String>{
          "en": "Swazi lilangeni",
          "fi": "Lilangeni"
        },
        decimals: 2
    ),
    "THB": CurrencyOption(
        code: "THB",
        localizations: <String, String>{
          "en": "Thai baht",
          "fi": "Thaimaan baht"
        },
        decimals: 2
    ),
    "TJS": CurrencyOption(
        code: "TJS",
        localizations: <String, String>{
          "en": "Tajikistani somoni",
          "fi": "Tadžikistanin somoni"
        },
        decimals: 2
    ),
    "TMT": CurrencyOption(
        code: "TMT",
        localizations: <String, String>{
          "en": "Turkmenistan manat",
          "fi": "Turkmenistanin manat"
        },
        decimals: 2
    ),
    "TND": CurrencyOption(
        code: "TND",
        localizations: <String, String>{
          "en": "Tunisian dinar",
          "fi": "Tunisian dinaari"
        },
        decimals: 3
    ),
    "TOP": CurrencyOption(
        code: "TOP",
        localizations: <String, String>{
          "en": "Tongan paʻanga",
          "fi": "Tongan paʻanga"
        },
        decimals: 2
    ),
    "TRY": CurrencyOption(
        code: "TRY",
        localizations: <String, String>{
          "en": "Turkish lira",
          "fi": "Turkin liira"
        },
        decimals: 2
    ),
    "TTD": CurrencyOption(
        code: "TTD",
        localizations: <String, String>{
          "en": "Trinidad and Tobago dollar",
          "fi": "Trinidadin ja Tobagon dollari"
        },
        decimals: 2
    ),
    "TWD": CurrencyOption(
        code: "TWD",
        localizations: <String, String>{
          "en": "New Taiwan dollar",
          "fi": "Uusi Taiwanin dollari"
        },
        decimals: 1
    ),
    "TZS": CurrencyOption(
        code: "TZS",
        localizations: <String, String>{
          "en": "Tanzanian shilling",
          "fi": "Tansanian šillinki"
        },
        decimals: 2
    ),
    "UAH": CurrencyOption(
        code: "UAH",
        localizations: <String, String>{
          "en": "Ukrainian hryvnia",
          "fi": "Ukrainan hryvnia"
        },
        decimals: 2
    ),
    "UGX": CurrencyOption(
        code: "UGX",
        localizations: <String, String>{
          "en": "Ugandan shilling",
          "fi": "Ugandan šillinki"
        },
        decimals: 0
    ),
    "USD": CurrencyOption(
        code: "USD",
        localizations: <String, String>{
          "en": "United States dollar",
          "fi": "Yhdysvaltain dollari"
        },
        decimals: 2
    ),
    "UYU": CurrencyOption(
        code: "UYU",
        localizations: <String, String>{
          "en": "Uruguayan peso",
          "fi": "Uruguayn peso"
        },
        decimals: 2
    ),
    "UZS": CurrencyOption(
        code: "UZS",
        localizations: <String, String>{
          "en": "Uzbekistani sum",
          "fi": "Uzbekistanin som"
        },
        decimals: 2
    ),
    "VEF": CurrencyOption(
        code: "VEF",
        localizations: <String, String>{
          "en": "Venezuelan bolívar",
          "fi": "Venezuelan bolívar"
        },
        decimals: 2
    ),
    "VND": CurrencyOption(
        code: "VND",
        localizations: <String, String>{
          "en": "Vietnamese đồng",
          "fi": "Vietnamin đồng"
        },
        decimals: 0
    ),
    "VUV": CurrencyOption(
        code: "VUV",
        localizations: <String, String>{
          "en": "Vanuatu vatu",
          "fi": "Vanuatun vatu"
        },
        decimals: 0
    ),
    "WST": CurrencyOption(
        code: "WST",
        localizations: <String, String>{
          "en": "Samoan tala",
          "fi": "Samoan tālā"
        },
        decimals: 2
    ),
    "XAF": CurrencyOption(
        code: "XAF",
        localizations: <String, String>{
          "en": "CFA franc BEAC",
          "fi": "Keski-Afrikan CFA-frangi BEAC"
        },
        decimals: 0
    ),
    "XCD": CurrencyOption(
        code: "XCD",
        localizations: <String, String>{
          "en": "East Caribbean dollar",
          "fi": "Itä-Karibian dollari"
        },
        decimals: 2
    ),
    "XCG": CurrencyOption(
        code: "XCG",
        localizations: <String, String>{
          "en": "Caribbean guilder",
          "fi": "Karibian guldeni"
        },
        decimals: 2
    ),
    "XOF": CurrencyOption(
        code: "XOF",
        localizations: <String, String>{
          "en": "CFA franc BCEAO",
          "fi": "Länsi-Afrikan CFA-frangi BCEAO"
        },
        decimals: 0
    ),
    "XPF": CurrencyOption(
        code: "XPF",
        localizations: <String, String>{
          "en": "CFP franc (franc Pacifique)",
          "fi": "CFP-frangi"
        },
        decimals: 0
    ),
    "YER": CurrencyOption(
        code: "YER",
        localizations: <String, String>{
          "en": "Yemeni rial",
          "fi": "Jemenin rial"
        },
        decimals: 0
    ),
    "ZAR": CurrencyOption(
        code: "ZAR",
        localizations: <String, String>{
          "en": "South African rand",
          "fi": "Etelä-Afrikan randi"
        },
        decimals: 2
    ),
    "ZMW": CurrencyOption(
        code: "ZMW",
        localizations: <String, String>{
          "en": "Zambian kwacha",
          "fi": "Sambian kwacha"
        },
        decimals: 2
    ),
    "ZWG": CurrencyOption(
        code: "ZWG",
        localizations: <String, String>{
          "en": "Zimbabwe Gold",
          "fi": "Zimbabwen kulta"
        },
        decimals: 0
    ),
  };

  /// Returns the list of all currency options.
  static List<CurrencyOption> getCurrencyOptions() {
    return _currencyOptions.values.toList(growable: false);
  }

  /// Returns the currency option that corresponds to the given [code].
  static CurrencyOption? getCurrencyByCode(String code) {
    return _currencyOptions[code];
  }

}
