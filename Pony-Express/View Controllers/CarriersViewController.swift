//
//  CarriersViewController.swift
//  Pony-Express
//
//  Created by Josh Dinges on 7/19/20.
//  Copyright © 2020 Josh Dinges. All rights reserved.
//

import UIKit

enum Carrier: String, CaseIterable {
    case fedex = "Fedex"
    case ups = "UPS"
    case usps = "USPS"
    case dhl = "DHL"
    case amazon = "Amazon"
}

protocol CarrierDelegate: AnyObject {
    func selectCarrier(_ carrier: Carrier)
}

final class CarriersViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    private let carriers = Carrier.allCases

    var carrierDelegate: CarrierDelegate?
    var previouslySelectedCarrier: Carrier?
}

extension CarriersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        carriers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let carrierCell = tableView.dequeueReusableCell(withIdentifier: CarrierTableCell.defaultReuseIdentifier) as? CarrierTableCell else { return UITableViewCell() }
        let carrier = carriers[indexPath.row]
        carrierCell.carrier = carrier
        carrierCell.accessoryType = carrier == previouslySelectedCarrier ?? nil ? .checkmark : .none
        return carrierCell
    }
}

extension CarriersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let carrierCell = tableView.dequeueReusableCell(withIdentifier: CarrierTableCell.defaultReuseIdentifier) as? CarrierTableCell else { return }
        let carrier = carriers[indexPath.row]
        carrierCell.accessoryType = .checkmark
        carrierDelegate?.selectCarrier(carrier)
    }
}

final class CarrierTableCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!

    var carrier: Carrier? {
        didSet {
            guard let carrier = carrier else { return }
            titleLabel.text = carrier.rawValue
        }
    }
}
