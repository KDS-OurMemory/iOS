//
//  OptionSet+bitMask.swift
//  OurMemoryTask
//
//  Created by 이승기 on 2022/02/01.
//

import Foundation
//MARK: LSG 스크랩 소스함수 왜사용하는지 꼭 확인
public extension OptionSet where RawValue: FixedWidthInteger {
    func elements() -> AnySequence<Self> {
        var remainingBits = rawValue
        var bitMask:RawValue = 1
        return AnySequence {
            return AnyIterator {
                while remainingBits != 0 {
                    defer { bitMask = bitMask &* 2}
                    if remainingBits & bitMask != 0 {
                        remainingBits = remainingBits & ~bitMask
                        return Self(rawValue: bitMask)
                        
                    }
                }
                return nil
                
            }
        }
    }
}
