//
//  State.swift
//  GumBallMachine
//
//  Created by Homma Takushi on 2015/10/04.
//  Copyright © 2015年 mfmf.me. All rights reserved.
//

import Foundation

/// 基本の状態
class State {
  /**
  25セントを投入します
  */
  func insertQuarter() -> Bool {
    print("25セントを投入することはできません")
    return false
  }
  
  /**
  25セントを返却します
  */
  func ejectQuarter() -> Bool {
    print("返金できません")
    return false
  }
  
  /**
  クランクを回します
  */
  func turnCrank() -> Bool {
    print("クランクを回しましたが、ガムボールがありません")
    return false
  }

  /**
  ガムボールを販売します
  
  - returns: 販売するガムボールの数
  */
  func dispense() -> Int {
    print("販売するガムボールはありません")
    return 0
  }
  
  /**
  ガムボールを補充します
  */
  func refill(count:Int) -> Bool {
    print("まだガムボールは補充しなくても大丈夫です")
    return false
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  func toString() -> String {
    return "このマシンは売り切れです"
  }
}

/// ガムボールなし
class SoldOutState: State {
  /**
  ガムボールを補充します
  */
  override func refill(count: Int) -> Bool {
    print("ガムボールを\(count)個補充しました")
    return true
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  override func toString() -> String {
    return "このマシンは売り切れです"
  }
}

/// 25セント未受領
class NoQuarterState: State {
  /**
  25セントを投入します
  */
  override func insertQuarter() -> Bool {
    print("25セントを投入しました")
    return true
  }

  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  override func toString() -> String {
    return "マシンは25セントが投入されるのを待っています"
  }
}

/// 25セント受領
class HasQuarterState: State {
  /**
  25セントを返却します
  */
  override func ejectQuarter() -> Bool {
    print("25セントを返却しました")
    return true
  }
  
  /**
  クランクを回します
  */
  override func turnCrank() -> Bool {
    print("クランクを回しました……")
    return true
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  override func toString() -> String {
    return "このマシンはクランクを回されるのを待っています"
  }
}

/// ガムボール販売
class SoldState: State {
  /**
  ガムボールを販売します
  */
  override func dispense() -> Int {
    return 1
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  override func toString() -> String {
    return "このマシンはガムボールを販売しました"
  }
}

/// ガムボールが的中
class WinnerState: State {
  /**
  ガムボールを販売します
  */
  override func dispense() -> Int {
    print("当たりです！25セントで2つのガムボールがもらえます")
    return 2
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  override func toString() -> String {
    return "このマシンはガムボールを販売しました"
  }
}