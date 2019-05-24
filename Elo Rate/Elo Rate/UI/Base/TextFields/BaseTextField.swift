//
//  BaseTextField.swift
//  Elo Rate
//
//  Created by João Campos on 15/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit
import LayoutKit

@objc
protocol BaseTextFieldDelegate: class {

    func didUpdate(_ field: BaseTextField)
}

class BaseTextField: UITextField {

    private enum Constants {

        static let backgroundColor: UIColor = .brilliance

        enum placeholder {

            static let username: String = "Username"
            static let password: String = "Password"
        }

        enum text {

            /// .nero
            static let color: UIColor = .nero
            /// M - 14
            static let font = Branding.Font.stencil(.bpmono, .M).font
            static let insets = LayoutKitEdge(top: Branding.Spacing.S.float,
                                              left: Branding.Spacing.S.float,
                                              bottom: Branding.Spacing.S.float,
                                              right: Branding.Spacing.L.float)
        }

        enum layer {

            /// XXS - 4
            static let cornerRadius: CGFloat = Branding.Spacing.XXS.float
            /// 1
            static let borderWidth: CGFloat = 1
        }

        enum icon {
            /// XXS - 4
            static let size: CGFloat = Branding.Spacing.XXS.float
        }
    }

    enum FieldType {

        case username
        case password

        var isSecure: Bool {

            return self == .password
        }

        var placeholder: String {

            switch self {

            case .username:

                return Constants.placeholder.username

            case .password:

                return Constants.placeholder.password
            }
        }

        var regex: NSRegularExpression {

            switch self {

            case .username:

                return NSRegularExpression("^([a-z]{1})([a-z0-9]{1})[a-z0-9]+")

            case .password:

                return NSRegularExpression("^([a-z0-9]{2})[a-z0-9]+")
            }
        }
    }
    
    enum CustomState {
        
        case valid
        case error
        case pristine
    }

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

    private var isSecure: Bool = false {

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

        button.size(to: .height(Constants.icon.size), .width(Constants.icon.size))

        return button
    }()

    let type: FieldType

    private(set) var hasError: Bool = false

    private weak var baseTextFieldDelegate: BaseTextFieldDelegate?

    init(frame: CGRect = .zero, delegate: BaseTextFieldDelegate?, type: FieldType) {

        self.type = type

        self.customState = .pristine

        self.baseTextFieldDelegate = delegate
        
        super.init(frame: frame)
        
        self.configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setState(_ state: CustomState) {

        self.customState = state
    }
}

private extension BaseTextField {
    
    func configureView() {

        self.isSecureTextEntry = self.type.isSecure

        self.textColor = Constants.text.color
        self.tintColor = Constants.text.color
        
        self.font = Constants.text.font
        
        self.backgroundColor = Constants.backgroundColor
        self.layer.cornerRadius = Constants.layer.cornerRadius
        self.borderStyle = .none
        self.layer.borderWidth = Constants.layer.borderWidth
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale

        self.placeholder = self.type.placeholder

        self.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc
    func secureTextVisibility() {
        
        self.eyeButton.isSelected.toggle()

        self.isSecureTextEntry.toggle()
    }

    @objc
    func textDidChange() {

        self.baseTextFieldDelegate?.didUpdate(self)
    }
}

internal extension BaseTextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {

        return UIEdgeInsetsInsetRect(bounds, Constants.text.insets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        return UIEdgeInsetsInsetRect(bounds, Constants.text.insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {

        return UIEdgeInsetsInsetRect(bounds, Constants.text.insets)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        
        let rect = UIEdgeInsetsInsetRect(bounds, Constants.text.insets)
        
        let imageBounds = UIEdgeInsetsMake(0, rect.maxX, 0, Branding.Spacing.XS.float)
        
        return UIEdgeInsetsInsetRect(bounds, imageBounds)
    }
}
