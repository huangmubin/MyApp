//
//  Layouter.swift
//  My
//
//  Created by 黄穆斌 on 2018/3/11.
//  Copyright © 2018年 myron. All rights reserved.
//

import UIKit

// MARK: - Layouter

/** Layouter */
class Layouter {
    static var active: Bool = true
    static var prioprity: UILayoutPriority = .defaultHigh
}

infix operator -<= : AssignmentPrecedence
infix operator ->= : AssignmentPrecedence
infix operator -== : AssignmentPrecedence

// MARK: - Operator Object

extension Layouter {
    class Operator {
        weak var view: UIView?
        var attribute: NSLayoutAttribute
        init(view: UIView?, attribute: NSLayoutAttribute) {
            self.view = view
            self.attribute = attribute
        }
    }
}

// MARK: - Constraint Object

extension Layouter {
    class Constraint {
        var a: Operator?
        var b: Operator?
        var relate: NSLayoutRelation = .equal
        var multiplier: CGFloat = 1
        var constant: CGFloat = 0
        var prioprity: UILayoutPriority
        var active: Bool
        init(b: Operator) {
            self.b = b
            self.prioprity = Layouter.prioprity
            self.active = Layouter.active
        }
        func layout() -> NSLayoutConstraint {
            a!.view?.translatesAutoresizingMaskIntoConstraints = false
            b!.view?.translatesAutoresizingMaskIntoConstraints = false
            let layout = NSLayoutConstraint(
                item: a!.view!,
                attribute: a!.attribute,
                relatedBy: relate,
                toItem: b!.view,
                attribute: b!.attribute,
                multiplier: multiplier,
                constant: constant
            )
            layout.priority = prioprity
            layout.isActive = active
            return layout
        }
    }
}

// MARK: - Constraints Object

extension Layouter {
    class EqualConstraints {
        var view: UIView
        var attributes: [NSLayoutAttribute]
        var prioprity: UILayoutPriority
        var active: Bool
        init(view: UIView, attributes: [NSLayoutAttribute]) {
            self.view = view
            self.attributes = attributes
            self.prioprity = Layouter.prioprity
            self.active = Layouter.active
        }
        func layouts(item: UIView, relate: NSLayoutRelation) -> [NSLayoutConstraint] {
            var layouts = [NSLayoutConstraint]()
            view.translatesAutoresizingMaskIntoConstraints = false
            item.translatesAutoresizingMaskIntoConstraints = false
            for attribute in attributes {
                let layout = NSLayoutConstraint(
                    item: view,
                    attribute: attribute,
                    relatedBy: relate,
                    toItem: item,
                    attribute: attribute,
                    multiplier: 1,
                    constant: 0
                )
                layout.priority = prioprity
                layout.isActive = active
                layouts.append(layout)
            }
            return layouts
        }
        func constraints(item: UIView, relate: NSLayoutRelation) -> [Layouter.Constraint] {
            var constraints = [Layouter.Constraint]()
            for attribute in attributes {
                let constraint = Layouter.Constraint(b: Layouter.Operator(view: item, attribute: attribute))
                constraint.a = Layouter.Operator(view: view, attribute: attribute)
                constraint.relate = relate
                constraints.append(constraint)
            }
            return constraints
        }
    }
}

// MARK: - Operator && Constant

extension Layouter.Operator {
    static func + (left: Layouter.Operator, right: CGFloat) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.constant = right
        return c
    }
    static func + (left: Layouter.Operator, right: Float) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.constant = CGFloat(right)
        return c
    }
    static func + (left: Layouter.Operator, right: Double) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.constant = CGFloat(right)
        return c
    }
    static func + (left: Layouter.Operator, right: Int) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.constant = CGFloat(right)
        return c
    }
    
    static func - (left: Layouter.Operator, right: CGFloat) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.constant = -right
        return c
    }
    static func - (left: Layouter.Operator, right: Float) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.constant = CGFloat(-right)
        return c
    }
    static func - (left: Layouter.Operator, right: Double) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.constant = CGFloat(-right)
        return c
    }
    static func - (left: Layouter.Operator, right: Int) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.constant = CGFloat(-right)
        return c
    }
}

// MARK: - Operator && multiplier

extension Layouter.Operator {
    static func * (left: Layouter.Operator, right: CGFloat) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.multiplier = right
        return c
    }
    static func * (left: Layouter.Operator, right: Float) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.multiplier = CGFloat(right)
        return c
    }
    static func * (left: Layouter.Operator, right: Double) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.multiplier = CGFloat(right)
        return c
    }
    static func * (left: Layouter.Operator, right: Int) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.multiplier = CGFloat(right)
        return c
    }
    
}

// MARK: - Operator && Prioprity

extension Layouter.Operator {
    
    static func & (left: Layouter.Operator, right: Float) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.prioprity = UILayoutPriority(rawValue: right)
        return c
    }
    static func & (left: Layouter.Operator, right: CGFloat) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.prioprity = UILayoutPriority(rawValue: Float(right))
        return c
    }
    static func & (left: Layouter.Operator, right: Int) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.prioprity = UILayoutPriority(rawValue: Float(right))
        return c
    }
    static func & (left: Layouter.Operator, right: UILayoutPriority) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: left)
        c.prioprity = right
        return c
    }
    
}

// MARK: - Operators && Constraint -> Constraint

extension Layouter.Operator {
    static func == (left: Layouter.Operator, right: Layouter.Constraint) -> Layouter.Constraint {
        right.a = left
        right.relate = .equal
        return right
    }
    static func >= (left: Layouter.Operator, right: Layouter.Constraint) -> Layouter.Constraint {
        right.a = left
        right.relate = .greaterThanOrEqual
        return right
    }
    static func <= (left: Layouter.Operator, right: Layouter.Constraint) -> Layouter.Constraint {
        right.a = left
        right.relate = .lessThanOrEqual
        return right
    }
    
}


// MARK: - Operators && Constraint -> NSLayoutConstraint

extension Layouter.Operator {
    
    static func -== (left: Layouter.Operator, right: Layouter.Constraint) -> NSLayoutConstraint {
        right.a = left
        right.relate = .equal
        return right.layout()
    }
    
    static func ->= (left: Layouter.Operator, right: Layouter.Constraint) -> NSLayoutConstraint {
        right.a = left
        right.relate = .greaterThanOrEqual
        return right.layout()
    }
    static func -<= (left: Layouter.Operator, right: Layouter.Constraint) -> NSLayoutConstraint {
        right.a = left
        right.relate = .lessThanOrEqual
        return right.layout()
    }
    
}

// MARK: - Operators && Operator -> Constraint

extension Layouter.Operator {
    
    static func == (left: Layouter.Operator, right: Layouter.Operator) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: right)
        c.a = left
        c.relate = .equal
        return c
    }
    static func >= (left: Layouter.Operator, right: Layouter.Operator) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: right)
        c.a = left
        c.relate = .greaterThanOrEqual
        return c
    }
    static func <= (left: Layouter.Operator, right: Layouter.Operator) -> Layouter.Constraint {
        let c = Layouter.Constraint(b: right)
        c.a = left
        c.relate = .lessThanOrEqual
        return c
    }
}


// MARK: - Operators && Operator -> NSLayoutConstraint

extension Layouter.Operator {
    static func -== (left: Layouter.Operator, right: Layouter.Operator) -> NSLayoutConstraint {
        let c = Layouter.Constraint(b: right)
        c.a = left
        c.relate = .equal
        return c.layout()
    }
    
    static func ->= (left: Layouter.Operator, right: Layouter.Operator) -> NSLayoutConstraint {
        let c = Layouter.Constraint(b: right)
        c.a = left
        c.relate = .greaterThanOrEqual
        return c.layout()
    }
    static func -<= (left: Layouter.Operator, right: Layouter.Operator) -> NSLayoutConstraint {
        let c = Layouter.Constraint(b: right)
        c.a = left
        c.relate = .lessThanOrEqual
        return c.layout()
    }
}

// MARK: - Constraint && Constant

extension Layouter.Constraint {
    
    static func + (left: Layouter.Constraint, right: CGFloat) -> Layouter.Constraint {
        left.constant = right
        return left
    }
    static func + (left: Layouter.Constraint, right: Float) -> Layouter.Constraint {
        left.constant = CGFloat(right)
        return left
    }
    static func + (left: Layouter.Constraint, right: Int) -> Layouter.Constraint {
        left.constant = CGFloat(right)
        return left
    }
    static func + (left: Layouter.Constraint, right: Double) -> Layouter.Constraint {
        left.constant = CGFloat(right)
        return left
    }
    
    static func - (left: Layouter.Constraint, right: CGFloat) -> Layouter.Constraint {
        left.constant = -right
        return left
    }
    static func - (left: Layouter.Constraint, right: Float) -> Layouter.Constraint {
        left.constant = CGFloat(-right)
        return left
    }
    static func - (left: Layouter.Constraint, right: Int) -> Layouter.Constraint {
        left.constant = CGFloat(-right)
        return left
    }
    static func - (left: Layouter.Constraint, right: Double) -> Layouter.Constraint {
        left.constant = CGFloat(-right)
        return left
    }
}

// MARK: - Constraint && multiplier

extension Layouter.Constraint {
    
    static func * (left: Layouter.Constraint, right: CGFloat) -> Layouter.Constraint {
        left.multiplier = right
        return left
    }
    static func * (left: Layouter.Constraint, right: Float) -> Layouter.Constraint {
        left.multiplier = CGFloat(right)
        return left
    }
    static func * (left: Layouter.Constraint, right: Int) -> Layouter.Constraint {
        left.multiplier = CGFloat(right)
        return left
    }
    static func * (left: Layouter.Constraint, right: Double) -> Layouter.Constraint {
        left.multiplier = CGFloat(right)
        return left
    }
    
}

// MARK: - Constraint && prioprity

extension Layouter.Constraint {
    
    static func & (left: Layouter.Constraint, right: UILayoutPriority) -> Layouter.Constraint {
        left.prioprity = right
        return left
    }
    static func & (left: Layouter.Constraint, right: CGFloat) -> Layouter.Constraint {
        left.prioprity = UILayoutPriority(rawValue: Float(right))
        return left
    }
    static func & (left: Layouter.Constraint, right: Float) -> Layouter.Constraint {
        left.prioprity = UILayoutPriority(rawValue: Float(right))
        return left
    }
    static func & (left: Layouter.Constraint, right: Int) -> Layouter.Constraint {
        left.prioprity = UILayoutPriority(rawValue: Float(right))
        return left
    }
    static func & (left: Layouter.Constraint, right: Double) -> Layouter.Constraint {
        left.prioprity = UILayoutPriority(rawValue: Float(right))
        return left
    }
    
}

// MARK: - Extension

extension UIView {
    @discardableResult
    func layoutor(constaints: Layouter.Constraint...) -> [NSLayoutConstraint] {
        var layouts = [NSLayoutConstraint]()
        for c in constaints {
            layouts.append(c.layout())
        }
        self.addConstraints(layouts)
        return layouts
    }
}

extension UIView {
    
    var centerx: Layouter.Operator {
        return Layouter.Operator(view: self, attribute: .centerX)
    }
    var centery: Layouter.Operator {
        return Layouter.Operator(view: self, attribute: .centerY)
    }
    
    var width: Layouter.Operator {
        return Layouter.Operator(view: self, attribute: .width)
    }
    var height: Layouter.Operator {
        return Layouter.Operator(view: self, attribute: .height)
    }
    
    var leading: Layouter.Operator {
        return Layouter.Operator(view: self, attribute: .leading)
    }
    var trailing: Layouter.Operator {
        return Layouter.Operator(view: self, attribute: .trailing)
    }
    
    var top: Layouter.Operator {
        return Layouter.Operator(view: self, attribute: .top)
    }
    var bottom: Layouter.Operator {
        return Layouter.Operator(view: self, attribute: .bottom)
    }
    
}

// MARK: - UIView Weight Height

extension UIView {
    func width(_ size: CGFloat, relate: NSLayoutRelation = .equal, prioprity: UILayoutPriority? = nil, active: Bool? = nil) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let layout = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: relate,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: size
        )
        layout.priority = prioprity ?? Layouter.prioprity
        layout.isActive = active ?? Layouter.active
        return layout
    }
    func height(_ size: CGFloat, relate: NSLayoutRelation = .equal, prioprity: UILayoutPriority? = nil, active: Bool? = nil) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let layout = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: relate,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: size
        )
        layout.priority = prioprity ?? Layouter.prioprity
        layout.isActive = active ?? Layouter.active
        return layout
    }
}
