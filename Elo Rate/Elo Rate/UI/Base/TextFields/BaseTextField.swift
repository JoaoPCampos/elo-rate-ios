//
//  BaseTextField.swift
//  Elo Rate
//
//  Created by João Campos on 15/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit
import LayoutKit

protocol BaseTextFieldDelegate: class {

    func didUpdate(_ field: BaseTextField, with text: String)
}

class BaseTextField: UITextField {
    
    enum CustomState {
        
        case valid
        case error
        case pristine
    }
    
    private enum Constants {
        
        static let textInsets = LayoutKitEdge(top: Branding.Spacing.S.float,
                                          left: Branding.Spacing.S.float,
                                          bottom: Branding.Spacing.S.float,
                                          right: Branding.Spacing.L.float)
        static let textColor: UIColor = .nero
        static let cornerRadius: CGFloat = Branding.Spacing.XXS.float
        static let fontM = Branding.Font.stencil(.bpmono, .M).font
        static let iconSize: CGFloat = 5
    }
    
    var isSecure: Bool = false {
        
        didSet {
            
            self.isSecureTextEntry = self.isSecure
            
            if self.rightView != self.eyeButton {
                
                self.rightView = self.eyeButton
                self.rightViewMode = .always
            }
        }
    }
    
    private lazy var eyeButton: UIButton = {
        
        let button = UIButton(type: UIButtonType.custom).unmask()
        
        button.setImage(#imageLiteral(resourceName: "eye_icon").withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
        button.setImage(#imageLiteral(resourceName: "eye_icon").withRenderingMode(.alwaysOriginal), for: UIControlState.selected)
        
        button.addTarget(self, action: #selector(secureTextVisibility), for: UIControlEvents.touchUpInside)
        
        button.size(to: .height(Constants.iconSize), .width(Constants.iconSize))
        
        return button
    }()

    private(set) var customState: CustomState {

        didSet {

            switch self.customState {

            case .valid:

                self.layer.borderColor = UIColor.nero.cgColor

            case .error:

                self.layer.borderColor = UIColor.brakeLights.cgColor

            case .pristine:

                self.layer.borderColor = UIColor.nero.cgColor
            }
        }
    }

    weak var baseTextFieldDelegate: BaseTextFieldDelegate?

    private(set) var hasError: Bool = false

    init(frame: CGRect = .zero, baseTextFieldDelegate: BaseTextFieldDelegate) {

        self.baseTextFieldDelegate = baseTextFieldDelegate
        self.customState = .pristine
        
        super.init(frame: frame)
        
        self.configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BaseTextField {
    
    func configureView() {

        self.textColor = Constants.textColor
        self.tintColor = Constants.textColor
        
        self.font = Constants.fontM
        
        self.backgroundColor = .brilliance
        self.layer.cornerRadius = Constants.cornerRadius
        self.borderStyle = .none
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 2.0
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale

        self.addTarget(self, action: #selector(updateCustomState), for: .editingChanged)
    }
    
    @objc
    func secureTextVisibility() {
        
        self.eyeButton.isSelected.toggle()
        self.isSecureTextEntry.toggle()
    }

    @objc
    func updateCustomState() {

        guard let text = self.text else { return }

        let hasError = text.count < 3

        self.customState = hasError ? .error : .valid

        self.baseTextFieldDelegate?.didUpdate(self, with: text)
    }
}

internal extension BaseTextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {

        return UIEdgeInsetsInsetRect(bounds, Constants.textInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        return UIEdgeInsetsInsetRect(bounds, Constants.textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {

        return UIEdgeInsetsInsetRect(bounds, Constants.textInsets)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = UIEdgeInsetsInsetRect(bounds, Constants.textInsets)
        
        let imageBounds = UIEdgeInsetsMake(0, rect.maxX, 0, Branding.Spacing.XS.float)
        
        return UIEdgeInsetsInsetRect(bounds, imageBounds)
    }
}
