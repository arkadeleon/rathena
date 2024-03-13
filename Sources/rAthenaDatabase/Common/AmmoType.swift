//
//  AmmoType.swift
//  rAthena
//
//  Created by Leon Li on 2024/1/10.
//

import rAthenaCommon

public enum AmmoType: String, CaseIterable, CodingKey, Decodable {
    case arrow = "Arrow"
    case dagger = "Dagger"
    case bullet = "Bullet"
    case shell = "Shell"
    case grenade = "Grenade"
    case shuriken = "Shuriken"
    case kunai = "Kunai"
    case cannonball = "Cannonball"
    case throwweapon = "Throwweapon"
}

extension AmmoType: Identifiable {
    public var id: Int {
        switch self {
        case .arrow: RA_AMMO_ARROW
        case .dagger: RA_AMMO_DAGGER
        case .bullet: RA_AMMO_BULLET
        case .shell: RA_AMMO_SHELL
        case .grenade: RA_AMMO_GRENADE
        case .shuriken: RA_AMMO_SHURIKEN
        case .kunai: RA_AMMO_KUNAI
        case .cannonball: RA_AMMO_CANNONBALL
        case .throwweapon: RA_AMMO_THROWWEAPON
        }
    }
}

extension AmmoType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .arrow: "Arrow"
        case .dagger: "Dagger"
        case .bullet: "Bullet"
        case .shell: "Shell"
        case .grenade: "Grenade"
        case .shuriken: "Shuriken"
        case .kunai: "Kunai"
        case .cannonball: "Cannon Ball"
        case .throwweapon: "Throw Weapon"
        }
    }
}
