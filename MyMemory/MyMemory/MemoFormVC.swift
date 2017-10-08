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

        let alertV = UIViewController()
        let iconImage = UIImage(named: "warning-icon-60")
        alertV.view = UIImageView(image: iconImage)
        alertV.preferredContentSize = iconImage?.size ?? CGSize.zero
        
        // 내용 미입력시 경고
        guard self.contents.text.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            alert.setValue(alertV, forKey: "contentViewController")
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
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        let ts = TimeInterval(0.3)
        UIView.animate(withDuration: ts) {
            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
        }
    }
    // MARK : LifeCycle
    //
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        
        let bgImage = UIImage(named: "memo-background")!
        self.view.backgroundColor = UIColor(patternImage: bgImage)
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.backgroundColor = UIColor.clear
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 9
        self.contents.attributedText = NSAttributedString(string: " ", attributes: [NSAttributedStringKey.paragraphStyle : style])
        self.contents.text = ""
    }
}
