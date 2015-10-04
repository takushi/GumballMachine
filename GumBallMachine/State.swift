//
//  State.swift
//  GumBallMachine
//
//  Created by Homma Takushi on 2015/10/04.
//  Copyright © 2015年 mfmf.me. All rights reserved.
//

import Foundation

/**
*  状態
*/
protocol State {
  /**
  25セントを投入します
  */
  func insertQuarter()
  
  /**
  25セントを返却します
  */
  func ejectQuarter()
  
  /**
  クランクを回します
  */
  func turnCrank()
  
  /**
  ガムボールを販売します
  */
  func dispense()
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  func toString() -> String
}

/// ガムボールなし
class SoldOutState: State {
  /// ガムボールマシン
  let gumballMachine: GumballMachine
  
  /**
  イニシャライザ
  
  - parameter gumballMachine: ガムボールマシン
  
  - returns: ガムボールなしの状態
  */
  init(gumballMachine: GumballMachine) {
    self.gumballMachine = gumballMachine
  }
  
  /**
  25セントを投入します
  */
  func insertQuarter() {
    print("25セントを投入することはできません。このマシンは売り切れです")
  }
  
  /**
  25セントを返却します
  */
  func ejectQuarter() {
    print("返金できません。まだ25セントを投入していません")
  }
  
  /**
  クランクを回します
  */
  func turnCrank() {
    print("クランクを回しましたが、ガムボールがありません")
  }
  
  /**
  ガムボールを販売します
  */
  func dispense() {
    print("販売するガムボールはありません")
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  func toString() -> String {
    return "このマシンは売り切れです"
  }
}

/// 25セント未受領
class NoQuarterState: State {
  /// ガムボールマシン
  let gumballMachine: GumballMachine
  
  /**
  イニシャライザ
  
  - parameter gumballMachine: ガムボールマシン
  
  - returns: 25セント未受領の状態
  */
  init(gumballMachine: GumballMachine) {
    self.gumballMachine = gumballMachine
  }
  
  /**
  25セントを投入します
  */
  func insertQuarter() {
    print("25セントを投入しました")
    self.gumballMachine.state = self.gumballMachine.hasQuarterState
  }
  
  /**
  25セントを返却します
  */
  func ejectQuarter() {
    print("25セントを投入していません")
  }
  
  /**
  クランクを回します
  */
  func turnCrank() {
    print("クランクを回しましたが、25セントを投入していません")
  }
  
  /**
  ガムボールを販売します
  */
  func dispense() {
    print("まず支払いをする必要があります")
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  func toString() -> String {
    return "マシンは25セントが投入されるのを待っています"
  }
}

/// 25セント受領
class HasQuarterState: State {
  /// ガムボールマシン
  let gumballMachine: GumballMachine
  
  /**
  イニシャライザ
  
  - parameter gumballMachine: ガムボールマシン
  
  - returns: 25セント受領の状態
  */
  init(gumballMachine: GumballMachine) {
    self.gumballMachine = gumballMachine
  }
  
  /**
  25セントを投入します
  */
  func insertQuarter() {
    print("もう一度25セントを投入することはできません")
  }
  
  /**
  25セントを返却します
  */
  func ejectQuarter() {
    print("25セントを返却しました")
    self.gumballMachine.state = self.gumballMachine.noQuarterState
  }
  
  /**
  クランクを回します
  */
  func turnCrank() {
    print("クランクを回しました……")
    let winner = arc4random() % 10
    if winner == 0 && self.gumballMachine.count > 1 {
      self.gumballMachine.state = self.gumballMachine.winnerState
    } else {
      self.gumballMachine.state = self.gumballMachine.soldState
    }
  }
  
  /**
  ガムボールを販売します
  */
  func dispense() {
    print("販売するガムボールはありません")
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  func toString() -> String {
    return "このマシンはクランクを回されるのを待っています"
  }
}

/// ガムボール販売
class SoldState: State {
  /// ガムボールマシン
  let gumballMachine: GumballMachine
  
  /**
  イニシャライザ
  
  - parameter gumballMachine: ガムボールマシン
  
  - returns: ガムボール販売
  */
  init(gumballMachine: GumballMachine) {
    self.gumballMachine = gumballMachine
  }
  
  /**
  25セントを投入します
  */
  func insertQuarter() {
    print("お待ちください。すでにガムボールを出しています")
  }
  
  /**
  25セントを返却します
  */
  func ejectQuarter() {
    print("申し訳ありません。すでにクランクを回しています")
  }
  
  /**
  クランクを回します
  */
  func turnCrank() {
    print("2回回してもガムボールをもう1つ手に入れることはできません！")
  }
  
  /**
  ガムボールを販売します
  */
  func dispense() {
    self.gumballMachine.releaseBall()
    if self.gumballMachine.count > 0 {
      self.gumballMachine.state = self.gumballMachine.noQuarterState
    } else {
      print("おっと、ガムボールがなくなりました！")
      self.gumballMachine.state = self.gumballMachine.soldOutState
    }
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  func toString() -> String {
    return "このマシンはガムボールを販売しました"
  }
}

/// ガムボールが的中
class WinnerState: State {
  /// ガムボールマシン
  let gumballMachine: GumballMachine
  
  /**
  イニシャライザ
  
  - parameter gumballMachine: ガムボールマシン
  
  - returns: ガムボールが的中
  */
  init(gumballMachine: GumballMachine) {
    self.gumballMachine = gumballMachine
  }
  
  /**
  25セントを投入します
  */
  func insertQuarter() {
    print("お待ちください。すでにガムボールを出しています")
  }
  
  /**
  25セントを返却します
  */
  func ejectQuarter() {
    print("申し訳ありません。すでにクランクを回しています")
  }
  
  /**
  クランクを回します
  */
  func turnCrank() {
    print("2回回してもガムボールをもう1つ手に入れることはできません！")
  }
  
  /**
  ガムボールを販売します
  */
  func dispense() {
    print("当たりです！25セントで2つのガムボールがもらえます")
    
    self.gumballMachine.releaseBall()
    if self.gumballMachine.count == 0 {
      self.gumballMachine.state = self.gumballMachine.soldOutState
    } else {
      self.gumballMachine.releaseBall()
      if self.gumballMachine.count > 0 {
        self.gumballMachine.state = self.gumballMachine.noQuarterState
      } else {
        print("おっと、ガムボールがなくなりました！")
        self.gumballMachine.state = self.gumballMachine.soldOutState
      }
    }
  }
  
  /**
  ガムボールマシンの状態を出力します
  
  - returns: ガムボールマシンの状態
  */
  func toString() -> String {
    return "このマシンはガムボールを販売しました"
  }
}