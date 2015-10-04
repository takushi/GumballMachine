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
  class var soldOutState: State {
    struct Static {
      static let uniqueInstance: State = SoldOutState()
    }
    return Static.uniqueInstance
  }
  /// 25セント未受領
  class var noQuarterState: State {
    struct Static {
      static let uniqueInstance: State = NoQuarterState()
    }
    return Static.uniqueInstance
  }
  /// 25セント受領
  class var hasQuarterState: State {
    struct Static {
      static let uniqueInstance: State = HasQuarterState()
    }
    return Static.uniqueInstance
  }
  /// ガムボール販売
  class var soldState: State {
    struct Static {
      static let uniqueInstance: State = SoldState()
    }
    return Static.uniqueInstance
  }
  /// ガムボールが的中
  class var winnerState: State {
    struct Static {
      static let uniqueInstance: State = WinnerState()
    }
    return Static.uniqueInstance
  }

  /// 現在の状態
  var state: State
  /// ガムボールの数
  var count: Int
  
  /**
  イニシャライザ
  
  - parameter count: ガムボールの数
  
  - returns: ガムボールマシン
  */
  init(count:Int) {
    self.count = count

    if self.count > 0 {
      self.state = GumballMachine.noQuarterState
    } else {
      self.state = GumballMachine.soldOutState
    }
  }

  /**
  25セントを投入します
  */
  func insertQuarter() {
    if self.state.insertQuarter() {
      self.state = GumballMachine.hasQuarterState
    }
  }
  
  /**
  25セントを返却します
  */
  func ejectQuarter() {
    if self.state.ejectQuarter() {
      self.state = GumballMachine.noQuarterState
    }
  }
  
  /**
  クランクを回します
  */
  func turnCrank() {
    if self.state.turnCrank() {
      let winner = arc4random() % 10
      if winner == 0 && self.count > 1 {
        self.state = GumballMachine.winnerState
      } else {
        self.state = GumballMachine.soldState
      }
      
      empty: for _ in 1...self.state.dispense() {
        self.releaseBall()
        
        if self.count == 0 {
          break empty
        }
      }
      
      if self.count > 0 {
        self.state = GumballMachine.noQuarterState
      } else {
        print("おっと、ガムボールがなくなりました！")
        self.state = GumballMachine.soldOutState
      }
    }
  }
  
  /**
  ガムボールを提供します
  */
  private func releaseBall() {
    print("ガムボールがスロットから転がり出てきます……")
    if self.count != 0 {
      self.count -= 1
    }
  }
  
  /**
  ガムボールを補充します
  
  - parameter count: ガムボールの数
  */
  func refill(count:Int) {
    if self.state.refill(count) {
      self.count += count
      self.state = GumballMachine.noQuarterState
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