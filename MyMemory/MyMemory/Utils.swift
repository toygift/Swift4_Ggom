//
//  Utils.swift
//  MyMemory
//
//  Created by Jaeseong on 2017. 10. 13..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import Foundation
extension UIViewController {
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    func instanceTutorailVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
}
