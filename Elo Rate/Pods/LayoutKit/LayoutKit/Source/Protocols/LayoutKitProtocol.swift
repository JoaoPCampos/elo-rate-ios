//
//  LayoutKitProtocol.swift
//  LayoutKit
//
//  Created by João Campos on 12/04/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import UIKit

public protocol LayoutKitProtocol {
    
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}
