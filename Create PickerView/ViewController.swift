//
//  ViewController.swift
//  Create PickerView
//
//  Created by Engy on 11/3/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityNameTextField: UITextField!

    var selectedCities: [String] = ["", "", ""]

    let cities1 = [
        "Bangalore", "Hyderabad", "Guntur", "Vijayawada", "Nellore", "Tirupathi",
        "Chennai", "Mumbai", "Delhi"
    ]

    let cities2 = [
        "Kolkata", "Pune", "Ahmedabad", "Surat", "Jaipur", "Lucknow",
        "Kanpur", "Nagpur", "Coimbatore"
    ]

    let cities3 = [
        "Visakhapatnam", "Madurai", "Rajkot", "Agra", "Varanasi", "Bhopal",
        "Indore", "Jodhpur", "Udaipur", "Chandigarh", "Thane", "Mysore",
        "Kochi", "Vadodara", "Gurugram", "Nashik", "Dehradun", "Ranchi",
        "Aurangabad", "Patna", "Ludhiana", "Faridabad", "Noida", "Navi Mumbai"
    ]

    let pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialSelection()
        configurePickerView()
        setupToolbar()
    }

    private func setupInitialSelection() {
        selectedCities = [cities1[0], cities2[0], cities3[0]]
    }

    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        cityNameTextField.inputView = pickerView
    }

    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
        refreshButton.tintColor = .red

        toolbar.setItems([doneButton, refreshButton], animated: true)
        cityNameTextField.inputAccessoryView = toolbar
    }

    @objc private func doneButtonTapped() {
        updateCityNameTextField()
        cityNameTextField.resignFirstResponder()
    }

    @objc private func refreshButtonTapped() {
        resetPickerSelection()
    }

    private func resetPickerSelection() {
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.selectRow(0, inComponent: 1, animated: true)
        pickerView.selectRow(0, inComponent: 2, animated: true)

        setupInitialSelection()
        cityNameTextField.text = "Select Country"
        cityNameTextField.resignFirstResponder()
    }

    private func updateCityNameTextField() {
        cityNameTextField.text = selectedCities.joined(separator: ", ")
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return cities1.count
        case 1: return cities2.count
        default: return cities3.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return cities1[row]
        case 1: return cities2[row]
        default: return cities3[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0: selectedCities[0] = cities1[row]
        case 1: selectedCities[1] = cities2[row]
        default: selectedCities[2] = cities3[row]
        }
        updateCityNameTextField()
    }
}
