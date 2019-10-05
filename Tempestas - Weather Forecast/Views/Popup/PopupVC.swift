//
//  PopupVC.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 5/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit
import IBAnimatable

// MARK: - Popup Dismiss Delegate
protocol PopupDismissDelegate: class {
    func popupDismissed()
}

class PopupVC: UIViewController {

    @IBOutlet weak var popupView: AnimatableView!
    @IBOutlet weak var popupTitle: UILabel!
    @IBOutlet weak var popupDescription: UILabel!
    
    @IBOutlet weak var dismissButton: AnimatableButton!
    
    weak var delegate: PopupDismissDelegate?
    
    func setupPopup(withTitle title: String = "", description: String,
                    dismissButtonText: String? = nil) {
        // Set the texts
        popupTitle.text = title
        popupDescription.text = description
        
        // Change the dismiss button text only if needed
        guard dismissButtonText != nil else { return }
        dismissButton.setTitle(dismissButtonText, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // Dismisses the PopupVC
    @IBAction func onDismissButtonTap(_ sender: Any) {
        dismiss(animated: true) {
            // Call the delegate
            self.delegate?.popupDismissed()
        }
    }
}
