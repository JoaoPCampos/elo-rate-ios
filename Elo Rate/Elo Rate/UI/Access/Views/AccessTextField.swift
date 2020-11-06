//
//  AccessTextField.swift
//  Elo Rate
//
//  Created by João Campos on 09/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import UIKit
import LayoutKit

protocol AccessTextFieldDelegate: class {
    
    func textChanged()
}

class AccessTextField: UITextField {
    
    typealias TextChangedClosure = () -> Void

    private enum Constants {
        /// .brilliance
        static let backgroundColor: UIColor = .brilliance
        /// M + S + XS = 42
        static let height = Branding.Spacing.M.float + Branding.Spacing.S.float + Branding.Spacing.XS.float

        enum placeholder {

            static let email: String = "Email"
            static let username: String = "Username"
            static let password: String = "Password"
        }

        enum text {
            /// .nero
            static let color: UIColor = .nero
            /// M - 14
            static let font = Branding.Font.stencil(.bpmono, .M).font
            /// top: S, left: S, bottom: S, right: L
            static let insets = LayoutKitEdge(top: Branding.Spacing.S.float,
                                              left: Branding.Spacing.S.float,
                                              bottom: Branding.Spacing.S.float,
                                              right: Branding.Spacing.L.float)
        }

        enum layer {
            /// XXS - 4
            static let cornerRadius = Branding.Spacing.XXS.float
            /// 1
            static let borderWidth: CGFloat = 1.0
        }

        enum icon {
            /// XXS - 4
            static let size: CGFloat = Branding.Spacing.XXS.float
            /// XS - 6
            static let rightMargin: CGFloat = Branding.Spacing.XS.float
        }
    }

    private lazy var eyeButton: UIButton = {

        let button = UIButton(type: .custom).unmask()

        button.setImage(#imageLiteral(resourceName: "eye_icon").withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(#imageLiteral(resourceName: "eye_icon").withRenderingMode(.alwaysTemplate), for: .selected)

        button.addTarget(self, action: #selector(self.secureTextVisibility), for: .touchUpInside)

        button.tintColor = .silver

        button.size(to: .height(Constants.icon.size), .width(Constants.icon.size))

        return button
    }()
    
    private weak var accessTextFieldDelegate: AccessTextFieldDelegate?

    private let configuration: AccessTextField.Configuration

    init(_ configuration: AccessTextField.Configuration, delegate: AccessTextFieldDelegate) {

        self.configuration = configuration
        
        self.accessTextFieldDelegate = delegate

        super.init(frame: .zero)

        self.configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func isValid() -> Bool {
        
        guard let text = self.text else { return false }
        
        return self.configuration.isValid(text)
    }
}

// MARK: - Private
private extension AccessTextField {

    func configureView() {

        self.font = Constants.text.font

        self.textColor = Constants.text.color

        self.tintColor = Constants.text.color

        self.backgroundColor = Constants.backgroundColor

        self.borderStyle = .none

        self.layer.cornerRadius = Constants.layer.cornerRadius
        self.layer.borderWidth = Constants.layer.borderWidth
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale

        self.placeholder = self.configuration.placeholder

        if self.configuration.isSecure {

            self.isSecureTextEntry = true
            self.rightView = self.eyeButton
            self.rightViewMode = .always
        }

        self.size(to: .height(Constants.height))
        
        self.addTarget(self, action: #selector(self.updateBorder), for: .editingChanged)
    }

    @objc
    func secureTextVisibility() {

        self.eyeButton.isSelected.toggle()

        self.eyeButton.tintColor = self.eyeButton.isSelected ? .nero : .silver

        self.isSecureTextEntry.toggle()
    }
    
    @objc
    func updateBorder() {

        self.accessTextFieldDelegate?.textChanged()
        
        guard let text = self.text else { return }

        self.layer.borderColor = self.configuration.color(for: text)
    }
}

// MARK: - Public configuration
extension AccessTextField {

    enum Configuration {

        case email
        case username
        case password

        var isSecure: Bool {

            return self == .password
        }
        
        func isValid(_ text: String) -> Bool {
            
            return self.regex.matches(text)
        }

        var placeholder: String {

            switch self {
                
            case .email:
                
                return Constants.placeholder.email

            case .username:

                return Constants.placeholder.username

            case .password:

                return Constants.placeholder.password
            }
        }

        var regex: NSRegularExpression {

            switch self {
                
            case .email:
                
                return NSRegularExpression("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")

            case .username:

                return NSRegularExpression("^([a-z]{1})([a-z0-9]{1})[a-z0-9]+")

            case .password:

                return NSRegularExpression("^([a-z0-9]{2})[a-z0-9]+")
            }
        }

        func color(for text: String) -> CGColor {

            return self.isValid(text) ? UIColor.nero.cgColor : UIColor.brakeLights.cgColor
        }
    }
}

// MARK: - Internal
internal extension AccessTextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.inset(by: Constants.text.insets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.inset(by: Constants.text.insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {

        return bounds.inset(by: Constants.text.insets)
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {

        let rect = bounds.inset(by: Constants.text.insets)

        let imageBounds = UIEdgeInsets(top: 0,
                                       left: rect.maxX,
                                       bottom: 0,
                                       right: Constants.icon.rightMargin)

        return bounds.inset(by: imageBounds)
    }
}
