//
//  PackageCell.swift
//  Pony-Express
//
//  Created by Josh Dinges on 7/16/20.
//  Copyright © 2020 Josh Dinges. All rights reserved.
//

import UIKit

final class PackageCell: UITableViewCell {
    @IBOutlet private var trackingNumberLabel: UILabel!
    @IBOutlet private var carrierLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    var package = Package.empty {
        didSet {
            trackingNumberLabel.text = package.trackingNumber
            carrierLabel.text = package.carrier
            descriptionLabel.text = package.description
        }
    }
}
