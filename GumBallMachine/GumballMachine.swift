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
  /**
  *  現在の状態
  */
  private enum State: Int {
    /**
    *  ガムボールなし
    */
    case SOLD_OUT = 0
    
    /**
    *  25セント未受領
    */
    case NO_QUARTER = 1
    
    /**
    *  25セント受領
    */
    case HAS_QUARTER = 2
    
    /**
    *  ガムボール販売
    */
    case SOLD = 3
  }
  
  /// 現在の状態
  private var state: State
  /// ガムボールの数
  private var count: Int
  
  /**
  イニシャライザ
  
  - parameter count: ガムボールの数
  
  - returns: ガムボールマシン
  */
  init(count:Int) {
    self.state = State.SOLD_OUT
    
    self.count = count
    if self.count > 0 {
      self.state = State.NO_QUARTER
    }
  }
  
  /**
  25セントを投入します
  */
  func insertQuarter() {
    switch self.state {
    case State.HAS_QUARTER:
      print("もう一度25セントを投入することはできません")
    case State.NO_QUARTER:
      self.state = State.HAS_QUARTER
      print("25セントを投入しました")
    case State.SOLD_OUT:
      print("25セントを投入することはできません。このマシンは売り切れです")
    case State.SOLD:
      print("お待ちください。すでにガムボールを出しています")
    }
  }
  
  /**
  25セントを返却します
  */
  func ejectQuarter() {
    switch self.state {
    case State.HAS_QUARTER:
      print("25セントを返却しました")
      self.state = State.NO_QUARTER
    case State.NO_QUARTER:
      print("25セントを投入していません")
    case State.SOLD:
      print("申し訳ありません。すでにクランクを回しています")
    case State.SOLD_OUT:
      print("返金できません。まだ25セントを投入していません")
    }
  }
  
  /**
  クランクを回します
  */
  func turnCrank() {
    switch self.state {
    case State.SOLD:
      print("2回回してもガムボールをもう1つ手に入れることはできません！")
    case State.NO_QUARTER:
      print("クランクを回しましたが、25セントを投入していません")
    case State.SOLD_OUT:
      print("クランクを回しましたが、ガムボールがありません")
    case State.HAS_QUARTER:
      print("クランクを回しました……")
      self.state = State.SOLD
      self.dispense()
    }
  }
  
  /**
  ガムボールを販売します
  */
  func dispense() {
    switch self.state {
    case State.SOLD:
      print("ガムボールがスロットから転がり出てきます")
      self.count -= 1
      if self.count == 0 {
        print("おっと、ガムボールがなくなりました！")
        self.state = State.SOLD
      } else {
        self.state = State.NO_QUARTER
      }
    case State.NO_QUARTER:
      print("まず支払いをする必要があります")
    case State.SOLD_OUT:
      print("販売するガムボールはありません")
    case State.HAS_QUARTER:
      print("販売するガムボールはありません")
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
    switch self.state {
    case State.NO_QUARTER:
      str += "マシンは25セントが投入されるのを待っています\n"
    case State.SOLD_OUT:
      str += "このマシンは売り切れです\n"
    case State.HAS_QUARTER:
      str += "このマシンはクランクを回されるのを待っています\n"
    case State.SOLD:
      str += "このマシンはガムボールを販売しました\n"
    }
    
    return str
  }
}