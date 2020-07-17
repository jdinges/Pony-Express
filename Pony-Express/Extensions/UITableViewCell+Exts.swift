//
//  UITableViewCell+Exts.swift
//  Pony-Express
//
//  Created by Josh Dinges on 7/16/20.
//  Copyright © 2020 Josh Dinges. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var defaultReuseIdentifier: String {
        String(describing: self)
    }
}
