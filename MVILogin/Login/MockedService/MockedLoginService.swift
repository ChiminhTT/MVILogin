//
//  MockedLoginService.swift
//  MVILogin
//
//  Created by maxence on 12/09/2018.
//  Copyright © 2018 maxence_ho. All rights reserved.
//

import RxSwift

enum LoginResult
{
  case success
  case failed
}

class MockedLoginService
{
  static func login(email: String, password: String) -> Single<LoginResult>
  {
    return Single.just(.success).delaySubscription(RxTimeInterval(2),
                                             scheduler: MainScheduler.instance)
  }
}
