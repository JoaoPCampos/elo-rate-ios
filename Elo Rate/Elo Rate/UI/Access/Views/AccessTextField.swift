//
//  AccessTextField.swift
//  Elo Rate
//
//  Created by João Campos on 09/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import UIKit
import LayoutKit

final class AccessTextField: UITextField {

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

    private lazy var eyeButton: UIButton = {

        let button = UIButton(type: UIButtonType.custom).unmask()

        button.setImage(#imageLiteral(resourceName: "eye_icon").withRenderingMode(.alwaysOriginal), for: UIControlState.normal)
        button.setImage(#imageLiteral(resourceName: "eye_icon").withRenderingMode(.alwaysOriginal), for: UIControlState.selected)

        button.addTarget(self, action: #selector(self.secureTextVisibility), for: UIControlEvents.touchUpInside)

        button.size(to: .height(Constants.icon.size), .width(Constants.icon.size))

        return button
    }()

    private let configuration: AccessTextField.Configuration

    init(frame: CGRect = .zero,
         _ configuration: AccessTextField.Configuration,
         delegate: UITextFieldDelegate) {

        self.configuration = configuration

        super.init(frame: frame)

        self.delegate = delegate

        self.configureView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
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
    }

    @objc
    func secureTextVisibility() {

        self.eyeButton.isSelected.toggle()

        self.isSecureTextEntry.toggle()
    }
}

// MARK: - Public configuration
extension AccessTextField {

    enum Configuration {

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

        var errorColor: CGColor { return UIColor.brakeLights.cgColor }

        var validColor: CGColor { return UIColor.nero.cgColor }
    }
}

// MARK: - Internal
internal extension AccessTextField {

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