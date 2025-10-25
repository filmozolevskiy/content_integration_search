view: affiliate_mapping {
  derived_table: {
    sql:
      SELECT 1 AS affiliate_id, 'Direct' AS affiliate_name
      UNION ALL SELECT 8, 'SkyScanner'
      UNION ALL SELECT 9, 'CheapFlights_CA'
      UNION ALL SELECT 10, 'CheapFlights_US'
      UNION ALL SELECT 11, 'FareCompare'
      UNION ALL SELECT 12, 'BookingBuddy'
      UNION ALL SELECT 13, 'Momondo'
      UNION ALL SELECT 14, 'TripAdvisor'
      UNION ALL SELECT 15, 'AdWords'
      UNION ALL SELECT 16, 'Kayak'
      UNION ALL SELECT 17, 'IntentMedia'
      UNION ALL SELECT 18, 'HotWire'
      UNION ALL SELECT 19, 'Orbitz'
      UNION ALL SELECT 20, 'Travelocity'
      UNION ALL SELECT 21, 'DoHop'
      UNION ALL SELECT 22, 'TravelZoo'
      UNION ALL SELECT 23, 'BookingWiz'
      UNION ALL SELECT 24, 'TripBase'
      UNION ALL SELECT 25, 'ClickTripz'
      UNION ALL SELECT 26, 'Fly'
      UNION ALL SELECT 27, 'TripMama'
      UNION ALL SELECT 28, 'TravelGrove'
      UNION ALL SELECT 29, 'StudentUniverse'
      UNION ALL SELECT 30, 'Tripl'
      UNION ALL SELECT 31, 'TripSearch'
      UNION ALL SELECT 32, 'Bing Ads'
      UNION ALL SELECT 33, 'Criteo'
      UNION ALL SELECT 34, 'Fetchback'
      UNION ALL SELECT 35, 'TravelSpec'
      UNION ALL SELECT 36, 'Ad Roll'
      UNION ALL SELECT 37, 'FlightOMart'
      UNION ALL SELECT 38, 'Email Alerts'
      UNION ALL SELECT 39, 'Lowfares-Farespotter'
      UNION ALL SELECT 40, 'Phone Agent'
      UNION ALL SELECT 41, 'AdWords-2'
      UNION ALL SELECT 42, 'DBM'
      UNION ALL SELECT 43, 'COST'
      UNION ALL SELECT 44, 'Paid Social'
      UNION ALL SELECT 45, 'faresonic'
      UNION ALL SELECT 46, 'Kayak_ADS'
      UNION ALL SELECT 47, 'Kayak Compare'
      UNION ALL SELECT 48, 'TripAdvisor Compare'
      UNION ALL SELECT 49, 'Kayak Whiskey'
      UNION ALL SELECT 50, 'Yulair'
      UNION ALL SELECT 500, 'uncommon_search'
      UNION ALL SELECT 501, 'uncommon_device'
      UNION ALL SELECT 503, 'KAYAK METAA'
      UNION ALL SELECT 504, 'hipmunk'
      UNION ALL SELECT 505, 'TomorrowWorld'
      UNION ALL SELECT 506, 'Jetcost'
      UNION ALL SELECT 507, 'FareDetect'
      UNION ALL SELECT 508, 'Jetradar'
      UNION ALL SELECT 509, 'LiliGo'
      UNION ALL SELECT 510, 'Email Campaigns'
      UNION ALL SELECT 511, 'Social Media'
      UNION ALL SELECT 512, 'Phone Agent - Elite Member Only'
      UNION ALL SELECT 513, 'YieldMo'
      UNION ALL SELECT 514, 'MasterCard Promo'
      UNION ALL SELECT 515, 'FareCompare Compare'
      UNION ALL SELECT 516, 'CJ'
      UNION ALL SELECT 519, 'Mobile App'
      UNION ALL SELECT 520, 'Direct'
      UNION ALL SELECT 521, 'AdWords'
      UNION ALL SELECT 522, 'Phone Agent'
      UNION ALL SELECT 523, 'CheapFlights'
      UNION ALL SELECT 524, 'IntentMedia'
      UNION ALL SELECT 525, 'BookingWiz'
      UNION ALL SELECT 531, 'Skiplagged'
      UNION ALL SELECT 541, 'AdWords JF CA'
      UNION ALL SELECT 551, 'AdWords-2 JF CA'
      UNION ALL SELECT 561, 'Skiplagged Compare'
      UNION ALL SELECT 571, 'Bing Ads JF CA'
      UNION ALL SELECT 581, 'Accordant'
      UNION ALL SELECT 591, 'Skiplagged Mobile Web'
      UNION ALL SELECT 601, 'Skyscanner Compare'
      UNION ALL SELECT 611, 'AdWords FH US'
      UNION ALL SELECT 621, 'AdWords-2 FH US'
      UNION ALL SELECT 622, 'JustflyTravelClub'
      UNION ALL SELECT 632, 'Bing Ads FH US'
      UNION ALL SELECT 642, 'Bing Ads FH US-2'
      UNION ALL SELECT 652, 'Z DEV TEST'
      UNION ALL SELECT 662, 'Kayak APP'
      UNION ALL SELECT 672, 'Email Alerts-2'
      UNION ALL SELECT 682, 'Bing Ads-2'
      UNION ALL SELECT 692, 'Return Customers'
      UNION ALL SELECT 702, 'Traditional Media'
      UNION ALL SELECT 712, 'BookWithMatrix'
      UNION ALL SELECT 732, 'YDeals'
      UNION ALL SELECT 733, 'MediaAlpha'
      UNION ALL SELECT 742, 'LeftTravel'
      UNION ALL SELECT 752, 'Momentum Employees'
      UNION ALL SELECT 762, 'SkipLagged Facilitated'
      UNION ALL SELECT 772, 'Flytrippers'
      UNION ALL SELECT 773, 'Momondo Compare'
      UNION ALL SELECT 782, 'Kayak APP'
      UNION ALL SELECT 792, 'HipMunk Compare'
      UNION ALL SELECT 802, 'AirWander'
      UNION ALL SELECT 812, 'African Safari Booking'
      UNION ALL SELECT 822, 'Kayak - Email'
      UNION ALL SELECT 831, 'Kayak Compare Global'
      UNION ALL SELECT 841, 'Kayak Deals'
      UNION ALL SELECT 851, 'CJ-EXCL'
      UNION ALL SELECT 861, 'Kayak Car'
      UNION ALL SELECT 862, 'Unrestricted Search'
      UNION ALL SELECT 872, 'SEO'
      UNION ALL SELECT 882, 'Adwords FH Hotels'
      UNION ALL SELECT 892, 'Adwords JF Hotels'
      UNION ALL SELECT 901, 'Global Wide Media'
      UNION ALL SELECT 911, 'DistrictM'
      UNION ALL SELECT 921, 'Affirm'
      UNION ALL SELECT 931, 'Kayak Plus'
      UNION ALL SELECT 941, 'MediaAlpha - AfterPop'
      UNION ALL SELECT 951, 'Kayak Compare UK'
      UNION ALL SELECT 952, 'Google Flights Ads'
      UNION ALL SELECT 962, 'Test@'
      UNION ALL SELECT 971, 'CheapFlights_UK'
      UNION ALL SELECT 981, 'Meta Ghost Package'
      UNION ALL SELECT 991, 'Adwords-2-EXP'
      UNION ALL SELECT 1001, 'Adwords-EXP'
      UNION ALL SELECT 1011, 'AdWords-2 FH US-EXP'
      UNION ALL SELECT 1021, 'AdWords FH US-EXP'
      UNION ALL SELECT 1022, 'Bookable Opaques'
      UNION ALL SELECT 1032, 'AirHelp'
      UNION ALL SELECT 1042, 'Google Flights Meta'
      UNION ALL SELECT 1052, 'Influencer Marketing'
      UNION ALL SELECT 1061, 'volarisb2b'
      UNION ALL SELECT 1071, 'Flighthub Partner Portal'
      UNION ALL SELECT 1081, 'Flighthub Partner Portal - Venngo'
      UNION ALL SELECT 1091, 'Mobile App Logged In IOS'
      UNION ALL SELECT 1101, 'Skyscanner App'
      UNION ALL SELECT 1111, 'Airline Shutdown Email'
      UNION ALL SELECT 1121, 'Mobile App Not Logged In IOS'
      UNION ALL SELECT 1131, 'Mobile App Logged In Android'
      UNION ALL SELECT 1141, 'Mobile App Not Logged In Android'
      UNION ALL SELECT 1151, 'Flighthub Kiosk'
      UNION ALL SELECT 1161, 'RTB House'
      UNION ALL SELECT 1171, 'CruiseHub Phone Agent'
      UNION ALL SELECT 1181, 'Student'
      UNION ALL SELECT 1191, 'Unrestricted External'
      UNION ALL SELECT 1201, 'Flighthub Bundles'
      UNION ALL SELECT 1211, 'Flighthub Chat GPT'
      UNION ALL SELECT 1221, 'Wego'
      UNION ALL SELECT 1231, 'Agencia-Agent'
      UNION ALL SELECT 1241, 'Agencia-SME'
      UNION ALL SELECT 1251, 'Kayak Packages Ads'
      UNION ALL SELECT 1261, 'PaxDeals'
    ;;
  }

  dimension: affiliate_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.affiliate_id ;;
    hidden: yes
  }

  dimension: affiliate_name {
    label: "Affiliate Name"
    type: string
    sql: ${TABLE}.affiliate_name ;;
    description: "Name of the affiliate partner"
    group_label: "3. Search Source"
    suggestions: [
      "Direct",
      "SkyScanner",
      "CheapFlights_CA",
      "CheapFlights_US",
      "FareCompare",
      "BookingBuddy",
      "Momondo",
      "TripAdvisor",
      "AdWords",
      "Kayak",
      "IntentMedia",
      "HotWire",
      "Orbitz",
      "Travelocity",
      "DoHop",
      "TravelZoo",
      "BookingWiz",
      "TripBase",
      "ClickTripz",
      "Fly",
      "TripMama",
      "TravelGrove",
      "StudentUniverse",
      "Tripl",
      "TripSearch",
      "Bing Ads",
      "Criteo",
      "Fetchback",
      "TravelSpec",
      "Ad Roll",
      "FlightOMart",
      "Email Alerts",
      "Lowfares-Farespotter",
      "Phone Agent",
      "AdWords-2",
      "DBM",
      "COST",
      "Paid Social",
      "faresonic",
      "Kayak_ADS",
      "Kayak Compare",
      "TripAdvisor Compare",
      "Kayak Whiskey",
      "Yulair",
      "uncommon_search",
      "uncommon_device",
      "KAYAK METAA",
      "hipmunk",
      "TomorrowWorld",
      "Jetcost",
      "FareDetect",
      "Jetradar",
      "LiliGo",
      "Email Campaigns",
      "Social Media",
      "Phone Agent - Elite Member Only",
      "YieldMo",
      "MasterCard Promo",
      "FareCompare Compare",
      "CJ",
      "Mobile App",
      "AdWords",
      "Phone Agent",
      "CheapFlights",
      "IntentMedia",
      "BookingWiz",
      "Skiplagged",
      "AdWords JF CA",
      "AdWords-2 JF CA",
      "Skiplagged Compare",
      "Bing Ads JF CA",
      "Accordant",
      "Skiplagged Mobile Web",
      "Skyscanner Compare",
      "AdWords FH US",
      "AdWords-2 FH US",
      "JustflyTravelClub",
      "Bing Ads FH US",
      "Bing Ads FH US-2",
      "Z DEV TEST",
      "Kayak APP",
      "Email Alerts-2",
      "Bing Ads-2",
      "Return Customers",
      "Traditional Media",
      "BookWithMatrix",
      "YDeals",
      "MediaAlpha",
      "LeftTravel",
      "Momentum Employees",
      "SkipLagged Facilitated",
      "Flytrippers",
      "Momondo Compare",
      "HipMunk Compare",
      "AirWander",
      "African Safari Booking",
      "Kayak - Email",
      "Kayak Compare Global",
      "Kayak Deals",
      "CJ-EXCL",
      "Kayak Car",
      "Unrestricted Search",
      "SEO",
      "Adwords FH Hotels",
      "Adwords JF Hotels",
      "Global Wide Media",
      "DistrictM",
      "Affirm",
      "Kayak Plus",
      "MediaAlpha - AfterPop",
      "Kayak Compare UK",
      "Google Flights Ads",
      "Test@",
      "CheapFlights_UK",
      "Meta Ghost Package",
      "Adwords-2-EXP",
      "Adwords-EXP",
      "AdWords-2 FH US-EXP",
      "AdWords FH US-EXP",
      "Bookable Opaques",
      "AirHelp",
      "Google Flights Meta",
      "Influencer Marketing",
      "volarisb2b",
      "Flighthub Partner Portal",
      "Flighthub Partner Portal - Venngo",
      "Mobile App Logged In IOS",
      "Skyscanner App",
      "Airline Shutdown Email",
      "Mobile App Not Logged In IOS",
      "Mobile App Logged In Android",
      "Mobile App Not Logged In Android",
      "Flighthub Kiosk",
      "RTB House",
      "CruiseHub Phone Agent",
      "Student",
      "Unrestricted External",
      "Flighthub Bundles",
      "Flighthub Chat GPT",
      "Wego",
      "Agencia-Agent",
      "Agencia-SME",
      "Kayak Packages Ads",
      "PaxDeals"
    ]
  }

  dimension: affiliate_label {
    label: "Affiliate (ID - Name)"
    type: string
    sql: CONCAT(CAST(${affiliate_id} AS VARCHAR), ' - ', ${affiliate_name}) ;;
    description: "Combined affiliate ID and name for easy reference"
    group_label: "3. Search Source"
    suggestions: [
      "1 - Direct",
      "8 - SkyScanner",
      "9 - CheapFlights_CA",
      "10 - CheapFlights_US",
      "11 - FareCompare",
      "12 - BookingBuddy",
      "13 - Momondo",
      "14 - TripAdvisor",
      "15 - AdWords",
      "16 - Kayak",
      "17 - IntentMedia",
      "18 - HotWire",
      "19 - Orbitz",
      "20 - Travelocity",
      "21 - DoHop",
      "22 - TravelZoo",
      "23 - BookingWiz",
      "24 - TripBase",
      "25 - ClickTripz",
      "26 - Fly",
      "27 - TripMama",
      "28 - TravelGrove",
      "29 - StudentUniverse",
      "30 - Tripl",
      "31 - TripSearch",
      "32 - Bing Ads",
      "33 - Criteo",
      "34 - Fetchback",
      "35 - TravelSpec",
      "36 - Ad Roll",
      "37 - FlightOMart",
      "38 - Email Alerts",
      "39 - Lowfares-Farespotter",
      "40 - Phone Agent",
      "41 - AdWords-2",
      "42 - DBM",
      "43 - COST",
      "44 - Paid Social",
      "45 - faresonic",
      "46 - Kayak_ADS",
      "47 - Kayak Compare",
      "48 - TripAdvisor Compare",
      "49 - Kayak Whiskey",
      "50 - Yulair",
      "500 - uncommon_search",
      "501 - uncommon_device",
      "503 - KAYAK METAA",
      "504 - hipmunk",
      "505 - TomorrowWorld",
      "506 - Jetcost",
      "507 - FareDetect",
      "508 - Jetradar",
      "509 - LiliGo",
      "510 - Email Campaigns",
      "511 - Social Media",
      "512 - Phone Agent - Elite Member Only",
      "513 - YieldMo",
      "514 - MasterCard Promo",
      "515 - FareCompare Compare",
      "516 - CJ",
      "519 - Mobile App",
      "520 - Direct",
      "521 - AdWords",
      "522 - Phone Agent",
      "523 - CheapFlights",
      "524 - IntentMedia",
      "525 - BookingWiz",
      "531 - Skiplagged",
      "541 - AdWords JF CA",
      "551 - AdWords-2 JF CA",
      "561 - Skiplagged Compare",
      "571 - Bing Ads JF CA",
      "581 - Accordant",
      "591 - Skiplagged Mobile Web",
      "601 - Skyscanner Compare",
      "611 - AdWords FH US",
      "621 - AdWords-2 FH US",
      "622 - JustflyTravelClub",
      "632 - Bing Ads FH US",
      "642 - Bing Ads FH US-2",
      "652 - Z DEV TEST",
      "662 - Kayak APP",
      "672 - Email Alerts-2",
      "682 - Bing Ads-2",
      "692 - Return Customers",
      "702 - Traditional Media",
      "712 - BookWithMatrix",
      "732 - YDeals",
      "733 - MediaAlpha",
      "742 - LeftTravel",
      "752 - Momentum Employees",
      "762 - SkipLagged Facilitated",
      "772 - Flytrippers",
      "773 - Momondo Compare",
      "782 - Kayak APP",
      "792 - HipMunk Compare",
      "802 - AirWander",
      "812 - African Safari Booking",
      "822 - Kayak - Email",
      "831 - Kayak Compare Global",
      "841 - Kayak Deals",
      "851 - CJ-EXCL",
      "861 - Kayak Car",
      "862 - Unrestricted Search",
      "872 - SEO",
      "882 - Adwords FH Hotels",
      "892 - Adwords JF Hotels",
      "901 - Global Wide Media",
      "911 - DistrictM",
      "921 - Affirm",
      "931 - Kayak Plus",
      "941 - MediaAlpha - AfterPop",
      "951 - Kayak Compare UK",
      "952 - Google Flights Ads",
      "962 - Test@",
      "971 - CheapFlights_UK",
      "981 - Meta Ghost Package",
      "991 - Adwords-2-EXP",
      "1001 - Adwords-EXP",
      "1011 - AdWords-2 FH US-EXP",
      "1021 - AdWords FH US-EXP",
      "1022 - Bookable Opaques",
      "1032 - AirHelp",
      "1042 - Google Flights Meta",
      "1052 - Influencer Marketing",
      "1061 - volarisb2b",
      "1071 - Flighthub Partner Portal",
      "1081 - Flighthub Partner Portal - Venngo",
      "1091 - Mobile App Logged In IOS",
      "1101 - Skyscanner App",
      "1111 - Airline Shutdown Email",
      "1121 - Mobile App Not Logged In IOS",
      "1131 - Mobile App Logged In Android",
      "1141 - Mobile App Not Logged In Android",
      "1151 - Flighthub Kiosk",
      "1161 - RTB House",
      "1171 - CruiseHub Phone Agent",
      "1181 - Student",
      "1191 - Unrestricted External",
      "1201 - Flighthub Bundles",
      "1211 - Flighthub Chat GPT",
      "1221 - Wego",
      "1231 - Agencia-Agent",
      "1241 - Agencia-SME",
      "1251 - Kayak Packages Ads",
      "1261 - PaxDeals"
    ]
  }
}

