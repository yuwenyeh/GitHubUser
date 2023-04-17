//
//  BaseXibView.swift
//  GitHubUser
//
//  Created by 葉育彣 on 2023/4/16.
//

import UIKit

@IBDesignable

class BaseXibView: UIView {
    @IBInspectable var nibName: String?
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
            xibSetup()
    }
    func xibSetup() {
        let boundle = Bundle(for: self.classForCoder)
        if nibName == nil {
            nibName = "\(self.classForCoder)"
        }
        let nib = UINib(nibName: nibName!, bundle: boundle)
        if let view = nib.instantiate(withOwner: self).first as? UIView {
            view.frame = self.bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(view)
        }
    }
}
