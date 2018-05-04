//
//  ToSViewController.swift
//  OverEats
//
//  Created by 배태웅 on 2018. 4. 4..
//  Copyright © 2018년 sangwook park. All rights reserved.
//

import UIKit

class ToSViewController: UIViewController {
    
    // 이용약관 버튼
    @IBOutlet weak var TosButton: UIButton! // 첫번째 약관
    @IBOutlet weak var PIPButton: UIButton! // 두번째 약관
    @IBOutlet weak var OptionButton: UIButton! // 선택 약관
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 버튼 관련 이벤트 처리
        TosButton.addTarget(self, action: #selector(self.clickedButton(_:)), for: .touchUpInside)
        PIPButton.addTarget(self, action: #selector(self.clickedButton(_:)), for: .touchUpInside)
        OptionButton.addTarget(self, action: #selector(self.clickedButton(_:)), for: .touchUpInside)
        
    }
    
    // 버튼 클릭 이벤트
    @objc func clickedButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    // 전체 선택 이벤트
    @IBAction func allTrue(_ sender: UIButton) {
        
        TosButton.isSelected = true
        PIPButton.isSelected = true
        OptionButton.isSelected = true
        
    }
    
    // 다음 버튼 이벤트
    @IBAction func nextButton(_ sender: UIButton) {
        
        // 필수 약관 2개 선택이 아닐경우
        guard TosButton.isSelected && PIPButton.isSelected else {
            
            // 경고 창 띄우기
            showAlert(alertTitle: "필수 약관 체크",
                      alertMessage: "필수 약관에 모두 동의하셔야 회원 가입이 가능합니다.",
                      actionTitle: "확인")
            
            return
        }
        
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateIDViewController") as! CreateIDViewController
        present(nextViewController, animated: true, completion: nil)
        
    }
    
    // 이전 화면으로 dismiss 하는 버튼
    @IBAction func dismissButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
