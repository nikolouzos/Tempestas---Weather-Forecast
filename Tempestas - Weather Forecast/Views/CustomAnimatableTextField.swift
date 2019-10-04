//
//  AnimatableField.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 4/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import IBAnimatable

/// Adds some extra functionality on top of the AnimatableTextField
@IBDesignable
class CustomAnimatableTextField: AnimatableTextField {
    
    /// Sets the horizontal inset for the text field
    @IBInspectable var horizontalInsets: CGFloat = 0 {
        didSet {
           layoutSubviews()
        }
    }
    
    /// Sets the vertical inset for the text field
    @IBInspectable var verticalInsets: CGFloat = 0 {
        didSet {
           layoutSubviews()
        }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInsets, dy: verticalInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInsets, dy: verticalInsets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInsets, dy: verticalInsets)
    }
}
