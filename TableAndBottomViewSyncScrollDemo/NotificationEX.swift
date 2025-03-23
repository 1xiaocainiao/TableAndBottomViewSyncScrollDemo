//
//  NotificationEX.swift
//  
//
//  Created by Apple on 2021/8/13.
//

import Foundation
import UIKit

extension Notification {
    func keyboardHeight() -> CGFloat {
        if let userInfo = self.userInfo, let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let size = value.cgRectValue.size
            return size.height
        }
        return 0
    }
    
    func keyboardAnimationCurve() -> UIView.AnimationOptions {
        if let userInfo = self.userInfo {
            if let curveValue = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.uintValue {
                return UIView.AnimationOptions(rawValue: curveValue << 16)
            }
        }
        return UIView.AnimationOptions.curveEaseInOut
    }
    
    func keyboardAnimationDuration() -> Double {
        if let userInfo = self.userInfo {
            if let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                return duration
            }
        }
        return 0.25
    }
}
