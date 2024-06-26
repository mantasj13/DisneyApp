//
//  Gesture+Extensions.swift
//  DisneyApp
//
//  Created by Mantas Jakstas on 27/4/24.
//

import Foundation

import SwiftUI
import Foundation

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
