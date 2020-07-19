//
//  CreatePackageViewController.swift
//  Pony-Express
//
//  Created by Josh Dinges on 7/18/20.
//  Copyright © 2020 Josh Dinges. All rights reserved.
//

import UIKit

final class CreatePackageViewController: UIViewController {
    @IBOutlet private var trackingNumberLabel: UILabel!
    @IBOutlet private var trackingNumberTextField: UITextField!
    @IBOutlet private var carrierLabel: UILabel!
    @IBOutlet private var carrierTextField: UITextField!
    @IBOutlet private var packageLabel: UILabel!
    @IBOutlet private var packageTextField: UITextField!
    @IBOutlet private var saveButton: UIBarButtonItem!

    var packageDelegate: PackageDelegate?
    private(set) var package = Package.empty {
        didSet {
            saveButton.isEnabled = package.isValid
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false
        trackingNumberTextField.becomeFirstResponder()
    }

    @IBAction func saveAction(_ sender: Any) {
        guard let packageDelegate = packageDelegate else { return }

        guard package.isValid else {
            print("Package is invalid because of the following reasons: \(package.errors)")
            return
        }
        packageDelegate.createNewPackage(package)
        dismiss(animated: true)
    }
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension CreatePackageViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case self.trackingNumberTextField:
            if let trackingNumberText = trackingNumberTextField.text {
                package.trackingNumber = trackingNumberText
            }
        case self.carrierTextField:
            if let carrierText = carrierTextField.text {
                package.carrier = carrierText
            }
        case self.packageTextField:
            if let packageText = packageTextField.text {
                package.description = packageText
            }
        default:
            print("something went wrong")
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.trackingNumberTextField:
            carrierTextField.becomeFirstResponder()
        case self.carrierTextField:
            packageTextField.becomeFirstResponder()
        case self.packageTextField:
            if !(trackingNumberTextField.text?.isEmpty ?? true) && !(carrierTextField.text?.isEmpty ?? true) {
                packageTextField.resignFirstResponder()
            } else if trackingNumberTextField.text?.isEmpty ?? true {
                trackingNumberTextField.becomeFirstResponder()
            } else if carrierTextField.text?.isEmpty ?? true {
                carrierTextField.becomeFirstResponder()
            }
        default:
            print("something went wrong")
            return false
        }

        if package.isValid {
            saveAction(self)
        }

        return true
    }
}
