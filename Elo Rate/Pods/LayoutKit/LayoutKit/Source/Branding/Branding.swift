//
//  Branding.swift
//  LayoutKit
//
//  Created by João Campos on 15/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit
import Foundation

public final class Branding {
    
    public enum Spacing {

        /// 48
        case L
        /// 24
        case M
        /// 12
        case S
        /// 6
        case XS
        /// 4
        case XXS
        /// 2
        case XXXS

        public var float: CGFloat {

            switch self {

            case .L: return 48

            case .M: return 24

            case .S: return 12

            case .XS: return 6

            case .XXS: return 4

            case .XXXS: return 2
            }
        }
    }

    public enum Font {

        case regular(Branding.Font.Name, Branding.Font.Size)
        case bold(Branding.Font.Name, Branding.Font.Size)
        case italic(Branding.Font.Name, Branding.Font.Size)
        case stencil(Branding.Font.Name, Branding.Font.Size)

        public enum Name: String {

            case bpmono = "BPmono"
        }

        public enum Size: CGFloat {

            /// 24
            case XXL = 24
            /// 18
            case XL = 18
            /// 16
            case L = 16
            /// 14
            case M = 14
            /// 12
            case S = 12
            /// 10
            case XS = 10
            /// 8
            case XXS = 8
        }

        public var font: UIFont {

            switch self {

            case .regular(let name, let size),
                 .bold(let name, let size),
                 .italic(let name, let size),
                 .stencil(let name, let size):

                guard let font = UIFont(name: name.rawValue, size: size.rawValue) else {

                    preconditionFailure("Unable to create font with name \(name.rawValue)")
                }

                return font
            }
        }
    }
}

