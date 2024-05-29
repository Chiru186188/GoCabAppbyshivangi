//
//  CustomSliderbutton2.swift
//  driver
//
//  Created by Admin on 23/05/24.
//  Copyright © 2024 minimal. All rights reserved.
//

import Foundation
import UIKit

struct ColorsNew {
    static let background = #colorLiteral(red: 0.657153666, green: 0.8692060113, blue: 0.6173200011, alpha: 1)
    static let draggedBackground = UIColor.clear
    static let tint = #colorLiteral(red: 0.1019607843, green: 0.4588235294, blue: 0.6235294118, alpha: 1)
}


protocol SlideToActionButtonNewDelegate: AnyObject {
    func didFinishNEW(identifier: String)
}

@IBDesignable
class SlideToActionButtonNew: UIView {
    var identifier: String = ""

    let handleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorsNew.draggedBackground
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    
    let handleViewImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "chevron.left.2", withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24, weight: .bold)))?.withRenderingMode(.alwaysTemplate)
        view.contentMode = .scaleAspectFit
        view.tintColor = ColorsNew.tint
        return view
    }()
    
    let draggedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = ColorsNew.draggedBackground
        view.layer.cornerRadius = 20
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = ColorsNew.tint
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.text = "Slide me!"
        return label
    }()
    
    private var trailingThumbnailViewConstraint: NSLayoutConstraint?
    private var panGestureRecognizer: UIPanGestureRecognizer!

    weak var delegate: SlideToActionButtonNewDelegate?
    
    private var xEndingPoint: CGFloat {
        return (bounds.width - handleView.bounds.width)
    }
    
    private var isFinished = false
    
    @IBInspectable var handleColor: UIColor = ColorsNew.draggedBackground {
        didSet {
            handleView.backgroundColor = handleColor
        }
    }
    
    @IBInspectable var handleImage: UIImage? {
        didSet {
            handleViewImage.image = handleImage
        }
    }
    
    @IBInspectable var labelText: String = "Slide me!" {
        didSet {
            titleLabel.text = labelText
        }
    }
    
    @IBInspectable var labelColor: UIColor = ColorsNew.tint {
        didSet {
            titleLabel.textColor = labelColor
        }
    }
    
    @IBInspectable var labelFontSize: CGFloat = 18 {
        didSet {
            titleLabel.font = .systemFont(ofSize: labelFontSize, weight: .semibold)
        }
    }
    
    @IBInspectable var background: UIColor = ColorsNew.background {
        didSet {
            self.backgroundColor = background
        }
    }
    
    @IBInspectable var handleCornerRadius: CGFloat = 20 {
        didSet {
            handleView.layer.cornerRadius = handleCornerRadius
            draggedView.layer.cornerRadius = handleCornerRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    func setup() {
        backgroundColor = ColorsNew.background
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = ColorsNew.tint.cgColor
        addSubview(titleLabel)
        addSubview(draggedView)
        addSubview(handleView)
        handleView.addSubview(handleViewImage)
        
        //MARK: - Constraints
        
        trailingThumbnailViewConstraint = handleView.trailingAnchor.constraint(equalTo: trailingAnchor)
        
        NSLayoutConstraint.activate([
            trailingThumbnailViewConstraint!,
            handleView.topAnchor.constraint(equalTo: topAnchor),
            handleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            handleView.widthAnchor.constraint(equalToConstant: 80),
            draggedView.topAnchor.constraint(equalTo: topAnchor),
            draggedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            draggedView.leadingAnchor.constraint(equalTo: handleView.leadingAnchor),
            draggedView.trailingAnchor.constraint(equalTo: trailingAnchor),
            handleViewImage.topAnchor.constraint(equalTo: handleView.topAnchor, constant: 10),
            handleViewImage.bottomAnchor.constraint(equalTo: handleView.bottomAnchor, constant: -10),
            handleViewImage.centerXAnchor.constraint(equalTo: handleView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        panGestureRecognizer.minimumNumberOfTouches = 1
        handleView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        if isFinished { return }
        let translatedPoint = -sender.translation(in: self).x

        switch sender.state {
        case .changed:
            if translatedPoint <= 0 {
                updateHandleXPosition(0)
            } else if translatedPoint >= xEndingPoint {
                updateHandleXPosition(xEndingPoint)
            } else {
                updateHandleXPosition(translatedPoint)
            }
        case .ended:
            if translatedPoint >= xEndingPoint {
                self.updateHandleXPosition(xEndingPoint)
                isFinished = true
                delegate?.didFinishNEW(identifier: self.identifier)
                UIView.animate(withDuration: 1) {
                    self.reset()
                }
            } else {
                UIView.animate(withDuration: 1) {
                    self.reset()
                }
            }
        default:
            break
        }
    }
    
    private func updateHandleXPosition(_ x: CGFloat) {
        trailingThumbnailViewConstraint?.constant = -x
    }

    func reset() {
        isFinished = false
        updateHandleXPosition(0)
    }
}
