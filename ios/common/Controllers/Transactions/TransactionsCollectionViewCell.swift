//
//  TripHistoryCollectionViewCell.swift
//  rider
//
//  Copyright © 2018 minimal. All rights reserved.
//

import UIKit


class TransactionsCollectionViewCell: UICollectionViewCell {
    public var transaction: Transaction?
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textdescription: UILabel!
    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var datelble: UILabel!
    @IBOutlet weak var MonthLAble: UILabel!
    @IBOutlet weak var Amount: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        //        if let tr = transaction {
        //            Amount.text = MyLocale.formattedCurrency(amount: tr.amount!, currency: tr.currency!)
        //            title.text = tr.transactionType?.capitalizingFirstLetter()
        //            let dateFormatter = DateFormatter()
        //            dateFormatter.dateStyle = .medium
        //            dateFormatter.timeStyle = .medium
        //
        //            if let startTimestamp = tr.transactionTime {
        //                textdescription.text = "\(MyLocale.formattedCurrency(amount: tr.amount!, currency: tr.currency!)) at \(dateFormatter.string(from: Date(timeIntervalSince1970: startTimestamp / 1000)))"
        //            }
        //        }
        //    }
        
        
        if let tr = transaction {
            Amount.text = MyLocale.formattedCurrency(amount: tr.amount!, currency: tr.currency!)
            title.text = tr.transactionType?.capitalizingFirstLetter()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .medium
            var  myInt = Int()
            myInt =   tr.id ?? 0
            let myString = String(myInt)
            print(myString)
            
            textdescription.text = "# \(myString)"

            if let startTimestamp = tr.transactionTime {
                
                let date = Date(timeIntervalSince1970: startTimestamp / 1000)
//                textdescription.text = "\(MyLocale.formattedCurrency(amount: tr.amount!, currency: tr.currency!)) at \(dateFormatter.string(from: date))"

                // Separate date and month
                let monthFormatter = DateFormatter()
                monthFormatter.dateFormat = "MMMM" // Full month name (e.g., January)
                let month = monthFormatter.string(from: date)
                
                let dayFormatter = DateFormatter()
                dayFormatter.dateFormat = "dd" // Day of the month (e.g., 31)
                let day = dayFormatter.string(from: date)
                
                // You can now use the `month` and `day` variables to set them in your labels
                datelble.text = month
                MonthLAble.text = day
            }
        }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
