//
//  JobExpStats.swift
//  rAthena
//
//  Created by Leon Li on 2024/1/10.
//

import rAthenaCommon

struct JobExpStats: Decodable {

    /// List of jobs associated to group.
    var jobs: [Job]

    /// Maximum base level. (Default: MAX_LEVEL)
    var maxBaseLevel: Int

    /// Base experience per level.
    var baseExp: [LevelExp]

    /// Maximum job level. (Default: MAX_LEVEL)
    var maxJobLevel: Int

    /// Job experience per level.
    var jobExp: [LevelExp]

    enum CodingKeys: String, CodingKey {
        case jobs = "Jobs"
        case maxBaseLevel = "MaxBaseLevel"
        case baseExp = "BaseExp"
        case maxJobLevel = "MaxJobLevel"
        case jobExp = "JobExp"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.jobs = try container.decode(Map<Job, Bool>.self, forKey: .jobs).keys
        self.maxBaseLevel = try container.decodeIfPresent(Int.self, forKey: .maxBaseLevel) ?? RA_MAX_LEVEL
        self.baseExp = try container.decodeIfPresent([JobExpStats.LevelExp].self, forKey: .baseExp) ?? []
        self.maxJobLevel = try container.decodeIfPresent(Int.self, forKey: .maxJobLevel) ?? RA_MAX_LEVEL
        self.jobExp = try container.decodeIfPresent([JobExpStats.LevelExp].self, forKey: .jobExp) ?? []
    }
}

extension JobExpStats {

    struct LevelExp: Decodable {

        /// Base / Job level.
        var level: Int

        /// Base / Job experience.
        var exp: Int

        enum CodingKeys: String, CodingKey {
            case level = "Level"
            case exp = "Exp"
        }
    }
}
