//
//  Distribute.swift
//  Cartography
//
//  Created by Robert Böhnke on 17/02/15.
//  Copyright (c) 2015 Robert Böhnke. All rights reserved.
//

import Foundation

typealias Accumulator = ([NSLayoutConstraint], LayoutProxy)

private func reduce(first: LayoutProxy, rest: [LayoutProxy], combine: (LayoutProxy, LayoutProxy) -> NSLayoutConstraint) -> [NSLayoutConstraint] {
    rest.last?.view.car_disableTranslatesAutoresizingMaskIntoConstraints()

    return reduce(rest, ([], first)) { (acc, current) -> Accumulator in
        var (constraints, previous) = acc

        return (constraints + [ combine(previous, current) ], current)
    }.0
}

public func distribute(by amount: Double, horizontally first: LayoutProxy, rest: LayoutProxy...) -> [NSLayoutConstraint] {
    return reduce(first, rest) { $0.trailing == $1.leading - amount }
}

public func distribute(by amount: Double, leftToRight first: LayoutProxy, rest: LayoutProxy...) -> [NSLayoutConstraint] {
    return reduce(first, rest) { $0.right == $1.left - amount  }
}

public func distribute(by amount: Double, vertically first: LayoutProxy, rest: LayoutProxy...) -> [NSLayoutConstraint] {
    return reduce(first, rest) { $0.bottom == $1.top - amount }
}
