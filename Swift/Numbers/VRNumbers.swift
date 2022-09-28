//
//  VRNumbers.swift
//  Versatilor
//
//  Created by Dhruv Upadhyay on 28/09/22.
//

import Foundation

extension NSInteger {
    // MARK: - Integer to BIG-Endian
    func getUInt8BigEndian() -> [UInt8] {
        var bigEndian = UInt32(self).bigEndian
        let count = MemoryLayout<UInt32>.size
        let bytePtr = withUnsafePointer(to: &bigEndian) {
            $0.withMemoryRebound(to: UInt8.self, capacity: count) {
                UnsafeBufferPointer(start: $0, count: count)
            }
        }

        var arrUInt8:[UInt8] = [UInt8]()

        for (_, value) in (Array(bytePtr)).enumerated() {
            arrUInt8.append(value)
        }
        return arrUInt8
    }
}

extension [UInt8] {
    // MARK: - [UInt8] BIG-Endian to UInt32
    /*** i.e.
        [0x7d, 0xcb, 0x3c, 0xec] = 2110471404 / 0x7dcb3cec(Hex)
        [0xdd, 0xe9, 0x12, 0x23] = 3723039267 / 0xdde91223(Hex)
     */
    func getInt() -> UInt32 {
        var value : UInt32 = 0
        let data = NSData(bytes: self, length: 4)
        data.getBytes(&value, length: 4)
        value = UInt32(bigEndian: value)
        return value
    }

    func getData() -> Data {
        let data = Data(bytes: self, count: self.count)
        return data
    }
}
