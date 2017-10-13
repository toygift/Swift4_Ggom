//
//  UserInfoManager.swift
//  MyMemory
//
//  Created by Jaeseong on 2017. 10. 13..
//  Copyright © 2017년 Jaeseong Lee. All rights reserved.
//

import Foundation
import UIKit

struct UserInfoKey {
    static let loginId = "LOGINID"
    static let account = "ACCOUNT"
    static let name = "NAME"
    static let profile = "PROFILE"
    static let tutorial = "TUTORIAL"
}

class UserInfoManager {
    var loginId: Int {
        get {
            return UserDefaults.standard.integer(forKey: UserInfoKey.loginId)
        }
        set(value) {
            let ud = UserDefaults.standard
            ud.set(value, forKey: UserInfoKey.loginId)
            ud.synchronize()
        }
    }
    var account: String? { // 비로그인상태일때 이 값을 nil로 설정하기 위해 옵셔널 ? 사용
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.account)
        }
        set(value) {
            let ud = UserDefaults.standard
            ud.set(value, forKey: UserInfoKey.account)
            ud.synchronize()
        }
    }
    var name: String? {
        get {
            return UserDefaults.standard.string(forKey: UserInfoKey.name)
        }
        set(value) {
            let ud = UserDefaults.standard
            ud.set(value, forKey: UserInfoKey.name)
            ud.synchronize()
        }
    }
    var profile: UIImage? {
        get {
            let ud = UserDefaults.standard
            if let _profile = ud.data(forKey: UserInfoKey.profile) {
                return UIImage(data: _profile)
            } else {
                return UIImage(named: "account.jpg")
            }
        }
        set(value) {
            if value != nil {
                let ud = UserDefaults.standard
                ud.set(UIImagePNGRepresentation(value!), forKey: UserInfoKey.profile)
                ud.synchronize()
            }
        }
    }
    var isLogin: Bool {
        if self.loginId == 0 || self.account == nil {
            return false
        } else {
            return true
        }
    }
    func login(account: String, passwd: String) -> Bool {
        if account.isEqual("toygift@naver.com") && passwd.isEqual("1234") {
            let ud = UserDefaults.standard
            ud.set(100, forKey: UserInfoKey.loginId)
            ud.set(account, forKey: UserInfoKey.account)
            ud.set("재성씨", forKey: UserInfoKey.name)
            ud.synchronize()
            return true
        } else {
            return false
        }
    }
    func logout() -> Bool {
        let ud = UserDefaults.standard
        ud.removeObject(forKey: UserInfoKey.loginId)
        ud.removeObject(forKey: UserInfoKey.account)
        ud.removeObject(forKey: UserInfoKey.name)
        ud.removeObject(forKey: UserInfoKey.profile)
        ud.synchronize()
        return true
    }
}

