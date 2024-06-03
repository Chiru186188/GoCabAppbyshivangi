//
//  TripHistoryCollectionViewCell.swift
//  rider
//
//  Copyright © 2018 minimal. All rights reserved.
//

import UIKit


class TripHistoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pickupLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var finishTimeLabel: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var textCost: UILabel!
    @IBOutlet weak var textStatus: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var Amountlbl: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        background.layer.borderColor = UIColor.darkGray.cgColor
        
        background.layer.borderWidth = 1
        
        
    }
}
