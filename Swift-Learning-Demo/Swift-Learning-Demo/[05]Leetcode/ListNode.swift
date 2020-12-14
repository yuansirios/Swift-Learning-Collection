//
//  ListNode.swift
//  Swift-Learning-Demo
//
//  Created by yuan xiaodong on 2020/12/5.
//  Copyright © 2020 yuan. All rights reserved.
//

import Foundation

public class ListNode {
  public var val: Int
  public var next: ListNode?
  public init() { self.val = 0; self.next = nil; }
  public init(_ val: Int) { self.val = val; self.next = nil; }
  public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next;}
}
