//
//  GumballMachine.swift
//  GumBallMachine
//
//  Created by Homma Takushi on 2015/10/04.
//  Copyright © 2015年 mfmf.me. All rights reserved.
//

import Foundation

/// ガムボールマシン
class GumballMachine {
  /// ガムボールなし
  var soldOutState: State!
  /// 25セント未受領
  var noQuarterState: State!
  /// 25セント受領
  var hasQuarterState: State!
  /// ガムボール販売
  var soldState: State!
  /// ガムボールが的中
  var winnerState: State!
  
  /// 現在の状態
  var state: State!
  /// ガムボールの数
  var count: Int
  
  /**
  イニシャライザ
  
  - parameter count: ガムボールの数
  
  - returns: ガムボールマシン
  */
  init(count:Int) {
    self.count = count

    self.soldOutState = SoldOutState(gumballMachine: self)
    self.noQuarterState = NoQuarterState(gumballMachine: self)
    self.hasQuarterState = HasQuarterState(gumballMachine: self)
    self.soldState = SoldState(gumballMachine: self)
    self.winnerState = WinnerState(gumballMachine: self)

    self.state = self.soldOutState
    if self.count > 0 {
      self.state = self.noQuarterState
    }
  }

  /**
  25セントを投入します
  */
  func insertQuarter() {
    self.state.insertQuarter()
  }
  
  /**
  25セントを返却します
  */
  func ejectQuarter() {
    self.state.ejectQuarter()
  }
  
  /**
  クランクを回します
  */
  func turnCrank() {
    self.state.turnCrank()
    self.state.dispense()
  }
  
  /**
  ガムボールを提供します
  */
  func releaseBall() {
    print("ガムボールがスロットから転がり出てきます……")
    if self.count != 0 {
      self.count -= 1
    }
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  func toString() -> String {
    var str: String
    str = "Might Gumball, Inc.\n"
    str += "Swift対応型据付型ガムボール  モデル#2015\n"
    str += "在庫：\(self.count)個のガムボール\n"
    str += self.state.toString() + "\n"
    
    return str
  }
}