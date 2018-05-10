//
//  Format.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 16..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import Foundation

class RegularExpression {
    
    // reg 적용
    func vaild(regEx: String, text: String) -> Bool{
        
        let textTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return textTest.evaluate(with: text)
    }
    
    // enum으로 정리
    enum regExChange: String {
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case mobile = "[0-9]{3}+-[0-9]{3,4}+-[0-9]{4}"
        case text = "^[A-Za-z가-힣]+$"
    }
    
//    // 카드 넘버 입력 관련 포맷
//    func format(cardNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
//        guard !cardNumber.isEmpty else { return “” } // text가 있는지 확인
//        guard let regex = try? NSRegularExpression(pattern: “[\\s-\\(\\)]“, options: .caseInsensitive) else { return “” } // 패턴
//
//    let textRange = NSString(string: cardNumber).range(of: cardNumber) // 현재 text의 range
//
//    // String형식으로 위에 값들이 적용된 text
//    var number = regex.stringByReplacingMatches(in: cardNumber, options: .init(rawValue: 0),
//                                                range: textRange, withTemplate: “”)
//
//    if number.count > 15 {
//    let lengthDigitIndex = number.index(number.startIndex, offsetBy: 16)
//    number = String(number[number.startIndex..<lengthDigitIndex])
//    }
//
//    let end = number.index(number.startIndex, offsetBy: number.count)
//    let range = number.startIndex..<end
//    var replaceOf = “”
//    var replaceWith = “”
//
//    // 어디서든 지울때 맨 뒤에 글자가 지우게 만든 것
//    if shouldRemoveLastDigit {
//    number = String(number[number.startIndex..<end])
//    }
//
//    switch (number.count / 4, number.count / 9, number.count / 13) {
//    case (0,_,_):
//    replaceOf = “(\\d{4})”
//    replaceWith = “$1"
//    case (_,0,_):
//    replaceOf = “(\\d{4})(\\d+)”
//    replaceWith = “$1-$2"
//    case (_,_,0):
//    replaceOf = “(\\d{4})(\\d{4})(\\d+)”
//    replaceWith = “$1-$2-$3"
//    default:
//    replaceOf = “(\\d{4})(\\d{4})(\\d{4})(\\d+)”
//    replaceWith = “$1-$2-$3-$4"
//    }
//
//    number = number.replacingOccurrences(of: replaceOf, with: replaceWith,
//    options: .regularExpression, range: range)
//
//    return number
//}
    
    
    // 자동으로 - 잡아주기
    func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        
        
        guard !phoneNumber.isEmpty else { return "" } // text가 있는지 확인
        
        // 패턴 정해주기
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        
        // 현재 text의 range
        let textRange = NSString(string: phoneNumber).range(of: phoneNumber)
        
        // String형식으로 위에 값들이 적용된 text
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: textRange, withTemplate: "")
        
        // range값 구하기
        func stringRange(numberCount: Int) -> Range<String.Index>{
            
            let end = number.index(number.startIndex, offsetBy: number.count - numberCount)
            let range = number.startIndex..<end
            return range
            
        }
        
        // offset은 전화번호 최대인 11자 까지 지정해주고 패턴 적용은 10까지 해줘야 한다
        if number.count > 10 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 11)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }
        
        // 어디서든 지울때 맨 뒤에 글자가 지우게 만든 것
        if shouldRemoveLastDigit {
            
            let end = number.index(number.startIndex, offsetBy: number.count)
            number = String(number[number.startIndex..<end])
            
        }
    
        if number.count <= 3 {
            
//            let end = number.index(number.startIndex, offsetBy: number.count-1)
//            let range = number.startIndex..<end
            
            number = number.replacingOccurrences(of: "(\\d{3})", with: "$1", options: .regularExpression, range: stringRange(numberCount: 1))
        }
        
        // 7개 이상 입력시 적용
        else if number.count <= 6 {
            
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "$1-$2", options: .regularExpression, range: stringRange(numberCount: 0))
            
        }
            
        // 10개 이상 입력시 적용
        else if number.count <= 10 {
            
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: stringRange(numberCount: 0))
            
        } else {
            
            // 11개 입력시 적용
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{4})(\\d+)", with: "$1-$2-$3", options: .regularExpression, range: stringRange(numberCount: 0))
            
        }
        return number
    }
    
    // E-mail 정규식
    func vaildEmail(emailID: String) -> Bool {
        
//        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: emailID)

        return vaild(regEx: regExChange.email.rawValue, text: emailID)
    }
    
    // PhoneNumer 정규식
    func vaildNumber(mobileNumber: String) -> Bool {
        
        return vaild(regEx: regExChange.mobile.rawValue, text: mobileNumber)
    }
    
    // Name 정규식
    func vaildText(textVaild: String) -> Bool {
        
        return vaild(regEx: regExChange.text.rawValue, text: textVaild)
        
    }
    
}
