//
//  SkillTree.swift
//  rAthena
//
//  Created by Leon Li on 2024/1/16.
//

public struct SkillTree: Comparable, Decodable, Identifiable {

    /// Job name.
    public var job: Job

    /// Map of job name from which Job will inherit the skill tree. (Default: null)
    /// Note that Job doesn't inherit the child skills, it only inherits the skills defined in Tree of the given job name.
    public var inherit: [Job]?

    /// List of skills available for the job. (Default: null)
    public var tree: [Skill]?

    public var id: Int {
        job.id
    }

    enum CodingKeys: String, CodingKey {
        case job = "Job"
        case inherit = "Inherit"
        case tree = "Tree"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.job = try container.decode(Job.self, forKey: .job)
        self.inherit = try container.decodeIfPresent(PairsNode<Job, Bool>.self, forKey: .inherit)?.keys
        self.tree = try container.decodeIfPresent([Skill].self, forKey: .tree)
    }

    public static func < (lhs: SkillTree, rhs: SkillTree) -> Bool {
        lhs.job.id < rhs.job.id
    }

    public static func == (lhs: SkillTree, rhs: SkillTree) -> Bool {
        lhs.job.id == rhs.job.id
    }
}

extension SkillTree {

    public struct Skill: Decodable {

        /// Skill name.
        public var name: String

        /// Max level of the skill. Set to 0 to remove the skill.
        public var maxLevel: Int

        /// Whether the skill is excluded from being inherited. (Default: false)
        public var exclude: Bool

        /// Minimum base level required to unlock the skill. (Default: 0)
        public var baseLevel: Int

        /// Minimum job level required to unlock the skill. (Default: 0)
        public var jobLevel: Int

        /// List of skills required to unlock the skill. (Default: null)
        public var requires: [PrerequisiteSkill]?

        enum CodingKeys: String, CodingKey {
            case name = "Name"
            case maxLevel = "MaxLevel"
            case exclude = "Exclude"
            case baseLevel = "BaseLevel"
            case jobLevel = "JobLevel"
            case requires = "Requires"
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.name = try container.decode(String.self, forKey: .name)
            self.maxLevel = try container.decode(Int.self, forKey: .maxLevel)
            self.exclude = try container.decodeIfPresent(Bool.self, forKey: .exclude) ?? false
            self.baseLevel = try container.decodeIfPresent(Int.self, forKey: .baseLevel) ?? 0
            self.jobLevel = try container.decodeIfPresent(Int.self, forKey: .jobLevel) ?? 0
            self.requires = try container.decodeIfPresent([PrerequisiteSkill].self, forKey: .requires)
        }
    }
}

extension SkillTree {

    public struct PrerequisiteSkill: Decodable {

        /// Skill name.
        public var name: String

        /// Skill level required. Set to 0 to remove the skill.
        public var level: Int

        enum CodingKeys: String, CodingKey {
            case name = "Name"
            case level = "Level"
        }
    }
}
