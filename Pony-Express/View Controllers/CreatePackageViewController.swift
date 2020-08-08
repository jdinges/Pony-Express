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
    private(set) var package = PackageObject.empty {
        didSet {
            saveButton.isEnabled = package.isValid
        }
    }
    private var previouslySelectedCarrier: Carrier?

    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false
        trackingNumberTextField.becomeFirstResponder()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let carriersViewController = segue.destination as? CarriersViewController else { return }
        carriersViewController.carrierDelegate = self
        carriersViewController.previouslySelectedCarrier = previouslySelectedCarrier
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

extension CreatePackageViewController: CarrierDelegate {
    func selectCarrier(_ carrier: Carrier) {
        package.carrier = carrier.rawValue
        carrierTextField.text = carrier.rawValue
        previouslySelectedCarrier = carrier
        navigationController?.popViewController(animated: true)
        guard textFieldShouldReturn(carrierTextField) else { return }
        textFieldDidEndEditing(carrierTextField)
    }
}

extension CreatePackageViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        guard textField == carrierTextField else { return true }
        performSegue(withIdentifier: "carrierSelect", sender: self)
        return false
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        guard textField == carrierTextField else { return true }
        previouslySelectedCarrier = nil
        return true
    }

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

    private func determineNextResponder() -> UITextField? {
        guard !(trackingNumberTextField.text?.isEmpty ?? true) else { return trackingNumberTextField }
        guard !(carrierTextField.text?.isEmpty ?? true) else { return carrierTextField }
        guard !(packageTextField.text?.isEmpty ?? true) else { return packageTextField }
        return nil
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let nextTextField = determineNextResponder() else { view.endEditing(true) ; return true }
        nextTextField.becomeFirstResponder()
        return true
    }
}
