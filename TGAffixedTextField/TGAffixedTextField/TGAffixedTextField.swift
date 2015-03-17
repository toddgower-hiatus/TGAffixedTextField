//
//  TGAffixedTextField.swift
//  TGAffixedTextField
//
//  Created by Todd Gower on 3/7/15.
//  Copyright (c) 2015 Todd Gower. All rights reserved.
//

import UIKit

class TGAffixedTextField: UITextField, UITextFieldDelegate  {
    
    var prefix: String? = nil
    var suffix: String? = nil
    let customTypingAttributes : Dictionary <NSObject, AnyObject>?
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.delegate = self
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        let dictionary: Dictionary = textField.typingAttributes!
        
        var combinedAttributes : NSMutableDictionary
        combinedAttributes = NSMutableDictionary(dictionary: dictionary)
        combinedAttributes.addEntriesFromDictionary(self.typingAttributes!)
        
        if (!isNilOrEmpty(suffix) && !isNilOrEmpty(textField.text)) {
                
            if let nonOptional : String = suffix {
                // the optional could successfully be converted to a non-optional
                
                let selectedRange: UITextRange = textField.selectedTextRange!
                let offset = -countElements(nonOptional)
                
                let newPosition: UITextPosition = textField.positionFromPosition(selectedRange.start, offset: offset)!
                let newRange: UITextRange = textField.textRangeFromPosition(newPosition, toPosition: newPosition)
               
                textField.selectedTextRange = newRange
            }
        }
        
    }

    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        if let unwrappedPrefix = self.prefix {
            // prefix is non-nil
            
            if textField.text == "" {
                textField.text = unwrappedPrefix
            } else if range.location <= countElements(unwrappedPrefix) - 1 && countElements(textField.text) == countElements(unwrappedPrefix){
                textField.text = ""
                return false
            } else if range.location <= countElements(unwrappedPrefix) - 1 {
                return false
            }
            
            return true
        } else if let unwrappedSuffix = suffix {
            // suffix is non-nil
            
            println( textField.text)
            if textField.text == "" {
                textField.text = string + unwrappedSuffix
                
                let selectedRange = textField.selectedTextRange
                let newPosition = textField.positionFromPosition(selectedRange!.start, offset: countElements(unwrappedSuffix))
                let newRange = textField.textRangeFromPosition(newPosition, toPosition: newPosition)
                
                textField.selectedTextRange = newRange
                return false
            }
            else if range.location >= (countElements(textField.text!) - (countElements(unwrappedSuffix) - 1)) {
                return false;
            }
            // don't delete space between number and suffix
            else if range.location == countElements(textField.text!) - countElements(unwrappedSuffix) && string == "" {
                return false;
            }
            // replace placeholder
            else if range.location == 0 && string == "" {
                textField.text = ""
                return false
            }
            
        }
        return true
    }
    
    
    
    
    func isNilOrEmpty(string: NSString?) -> Bool {
        switch string {
        case .Some(let nonNilString): return nonNilString.length == 0
        default:                      return true
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
