//
//  main.swift
//  GumBallMachine
//  「Head First デザインパターン 10章 Stateパターン：物事の状態」をSwiftで実装します。
//
//  Created by Homma Takushi on 2015/10/04.
//  Copyright © 2015年 mfmf.me. All rights reserved.
//

import Foundation

let gumballMachine: GumballMachine = GumballMachine(count: 5)

print(gumballMachine.toString())

gumballMachine.insertQuarter()
gumballMachine.turnCrank()

print(gumballMachine.toString())

gumballMachine.insertQuarter()
gumballMachine.turnCrank()
gumballMachine.insertQuarter()
gumballMachine.turnCrank()

print(gumballMachine.toString())