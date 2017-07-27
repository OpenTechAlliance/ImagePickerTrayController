//
//  ActionCell.swift
//  ImagePickerTrayController
//
//  Created by Laurin Brandner on 22.11.16.
//  Copyright © 2016 Laurin Brandner. All rights reserved.
//

import Foundation

let spacing = CGPoint(x: 26, y: 14)
fileprivate let stackViewOffset: CGFloat = 6

class ActionCell: UICollectionViewCell {

    fileprivate let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = spacing.x/2
        
        return stackView
    }()

    var actions = [ImagePickerAction]() {
        // It is sufficient to compare the length of the array
        // as actions can only be added but not removed
        
        willSet {
            if newValue.count != actions.count {
                stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            }
        }
        didSet {
            if stackView.arrangedSubviews.count != actions.count + 2 {
                stackView.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1)))
                actions.map { ActionButton(action: $0, target: self, selector: #selector(callAction(sender:))) }
                       .forEach { stackView.addArrangedSubview($0) }
                stackView.addArrangedSubview(UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1)))
            }
        }
    }
    
    var disclosureProcess: CGFloat = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    fileprivate func initialize() {
        contentView.addSubview(stackView)
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
    }
    
    // MARK: -
    
    @objc fileprivate func callAction(sender: UIButton) {
        if let index = stackView.arrangedSubviews.index(of: sender) {
            actions[index-1].call()
        }
    }

}

fileprivate class ActionButton: UIButton {
    
    // MARK: - Initialization
    
    init(action: ImagePickerAction, target: Any, selector: Selector) {
        super.init(frame: CGRect(x: 0, y: 0, width: 60, height: 45))
        
        addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45))
        
        setTitle(action.title, for: .normal)
        setTitleColor(.lightGray, for: .normal)
        setImage(action.image.withRenderingMode(.alwaysTemplate), for: .normal)
        
        imageView?.tintColor = .lightGray
        imageView?.contentMode = .scaleAspectFit
        
        titleLabel?.textAlignment = .center
        titleLabel?.font = .systemFont(ofSize: 13)
        
        backgroundColor = .white
        addTarget(target, action: selector, for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    fileprivate override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return contentRect.divided(atDistance: contentRect.midX, from: .minYEdge).slice
    }
    
    fileprivate override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return contentRect.divided(atDistance: contentRect.midX, from: .minYEdge).remainder
    }
    
}
