//
//  MemoFormVC.swift
//  MyMemory
//
//  Created by Jaeseong Lee on 2017. 10. 6..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate  {

    var subject: String!
    
    
    
    @IBOutlet var contents: UITextView!
    @IBOutlet var preview: UIImageView!
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        // 내용 미입력시 경고
        guard self.contents.text.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pick(_ sender: UIBarButtonItem) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        self.present(picker, animated: false, completion: nil)
    }
    
    /*UIImagePicker*/
    // 이미지 선택 완료시
    //
    //
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.preview.image = info[UIImagePickerControllerEditedImage] as? UIImage
        picker.dismiss(animated: false, completion: nil)
    }
    /*UITextView*/
    // 텍스트뷰 내용의 15자리까지 네이게이션타이틀에 표시
    //
    //
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        self.navigationItem.title = subject
    }
    // MARK : LifeCycle
    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        
    }
}
