//
//  InputBarView.swift
//  TableAndBottomViewSyncScrollDemo
//
// on 2025/3/23.
//

import UIKit
import SnapKit

class InputBarView: UIView {
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
        
        addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func becomeResponder() {
        textField.becomeFirstResponder()
    }
    
    func resignResponder() {
        textField.resignFirstResponder()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
