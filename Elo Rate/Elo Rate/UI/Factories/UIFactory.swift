//
//  UIFactory.swift
//  Elo Rate
//
//  Created by João Campos on 24/01/2020.
//  Copyright © 2020 João Campos. All rights reserved.
//

import UIKit
import LayoutKit

final class UIFactory {
    
    private enum Constants {
        
        /// .XXS - 4
        static let cornerRadius: CGFloat = Branding.Spacing.XXS.float

        enum button {
            
            /// .brilliance
            static let color: UIColor = .brilliance
            /// .goshawkGrey
            static let disabledColor: UIColor = .goshawkGrey
            /// .nero
            static let backgroundColor: UIColor = .nero
            /// .bpmono .M
            static let font = Branding.Font.stencil(.bpmono, .M).font
        }
    }
    
    static func button(title: String) -> UIButton {
        
        let button = UIButton(type: .roundedRect).unmask()
        
        button.layer.cornerRadius = Constants.cornerRadius
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        button.titleLabel?.font = Constants.button.font
        button.setTitle(title, for: .normal)
        button.setTitleColor(Constants.button.color, for: .normal)
        button.setTitleColor(Constants.button.disabledColor, for: .disabled)
        button.backgroundColor = Constants.button.backgroundColor
        
        return button
    }
}
