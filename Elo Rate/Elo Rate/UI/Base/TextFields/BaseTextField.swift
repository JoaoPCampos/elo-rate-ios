//
//  BaseTextField.swift
//  Elo Rate
//
//  Created by João Campos on 15/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

class BaseTextField: UITextField {

    let padding: UIEdgeInsets

    init(padding: UIEdgeInsets, frame: CGRect = .zero) {

        self.padding = padding

        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

internal extension BaseTextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {

        return UIEdgeInsetsInsetRect(bounds, self.padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {

        return UIEdgeInsetsInsetRect(bounds, self.padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {

        return UIEdgeInsetsInsetRect(bounds, self.padding)
    }
}
