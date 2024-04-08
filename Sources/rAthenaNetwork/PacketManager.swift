//
//  PacketManager.swift
//  rAthena
//
//  Created by Leon Li on 2024/4/8.
//

public class PacketManager {
    public static let shared = PacketManager()

    public let allPackets: [any PacketProtocol.Type] = [
        PACKET.CA.LOGIN.self,                   // 0x64
        PACKET.CA.CONNECT_INFO_CHANGE.self,     // 0x200
        PACKET.CA.EXE_HASHCHECK.self,           // 0x204

        PACKET.AC.ACCEPT_LOGIN.self,            // 0x69, 0xac4
        PACKET.AC.REFUSE_LOGIN.self,            // 0x6a, 0x83e

        PACKET.CH.ENTER.self,                   // 0x65
        PACKET.CH.SELECT_CHAR.self,             // 0x66
        PACKET.CH.MAKE_CHAR.self,               // 0x67, 0x970, 0xa39
        PACKET.CH.DELETE_CHAR.self,             // 0x68, 0x1fb
        PACKET.CH.EXE_HASHCHECK.self,           // 0x20b
        PACKET.CH.DELETE_CHAR_RESERVED.self,    // 0x827
        PACKET.CH.DELETE_CHAR_CANCEL.self,      // 0x82b

        PACKET.HC.ACCEPT_ENTER_NEO_UNION.self,  // 0x6b
        PACKET.HC.REFUSE_ENTER.self,            // 0x6c
        PACKET.HC.ACCEPT_MAKECHAR.self,         // 0b6d
        PACKET.HC.REFUSE_MAKECHAR.self,         // 0x6e
        PACKET.HC.ACCEPT_DELETECHAR.self,       // 0x6f
        PACKET.HC.REFUSE_DELETECHAR.self,       // 0x70

        PACKET.CZ.PING.self,                    // 0x187
        PACKET.CZ.EXE_HASHCHECK.self,           // 0x20c

        PACKET.SC.NOTIFY_BAN.self,              // 0x81
    ]
}
