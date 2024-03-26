//
//  Packets.CH.ExeHashcheck.swift
//  rAthena
//
//  Created by Leon Li on 2024/3/26.
//

extension Packets.CH {

    public struct ExeHashcheck: Packet {

        public var clientType: UInt8
        public var hashValue: [UInt8]

        public var packetName: String {
            return "PACKET_CH_EXE_HASHCHECK"
        }

        public var packetType: UInt16 {
            return 0x020B
        }

        public var packetLength: UInt16 {
            return 2 + 1 + 16
        }

        public init() {
            self.clientType = 0
            self.hashValue = []
        }

        public init(from decoder: BinaryDecoder) throws {
            let packetType = try decoder.decode(UInt16.self)
            guard packetType == 0x020B else {
                throw PacketDecodingError.packetMismatch(packetType)
            }
            self.clientType = try decoder.decode(UInt8.self)
            self.hashValue = try decoder.decode([UInt8].self, length: 16)
        }

        public func encode(to encoder: BinaryEncoder) throws {
            try encoder.encode(self.packetType)
            try encoder.encode(self.clientType)
            try encoder.encode(self.hashValue)
        }
    }
}
