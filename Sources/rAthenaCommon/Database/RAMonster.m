//
//  RAMonster.m
//  rAthena
//
//  Created by Leon Li on 2023/3/13.
//

#import "RAMonster.h"
#import "Enum/RASize.h"
#import "Enum/RARace.h"
#import "Enum/RARaceGroup.h"
#import "Enum/RAElement.h"

const NSInteger RAMonsterWalkSpeedFastest = 20;
const NSInteger RAMonsterWalkSpeedNormal = 150;
const NSInteger RAMonsterWalkSpeedSlowest = 1000;

@implementation RAMonster

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
        @"monsterID"        : @"Id",
        @"aegisName"        : @"AegisName",
        @"name"             : @"Name",
        @"japaneseName"     : @"JapaneseName",
        @"level"            : @"Level",
        @"hp"               : @"Hp",
        @"sp"               : @"Sp",
        @"baseExp"          : @"BaseExp",
        @"jobExp"           : @"JobExp",
        @"mvpExp"           : @"MvpExp",
        @"attack"           : @"Attack",
        @"attack2"          : @"Attack2",
        @"defense"          : @"Defense",
        @"magicDefense"     : @"MagicDefense",
        @"resistance"       : @"Resistance",
        @"magicResistance"  : @"MagicResistance",
        @"strength"         : @"Str",
        @"agility"          : @"Agi",
        @"vitality"         : @"Vit",
        @"intelligence"     : @"Int",
        @"dexterity"        : @"Dex",
        @"luck"             : @"Luk",
        @"attackRange"      : @"AttackRange",
        @"skillRange"       : @"SkillRange",
        @"chaseRange"       : @"ChaseRange",
        @"size"             : @"Size",
        @"race"             : @"Race",
        @"raceGroups"       : @"RaceGroups",
        @"element"          : @"Element",
        @"elementLevel"     : @"ElementLevel",
        @"walkSpeed"        : @"WalkSpeed",
        @"attackDelay"      : @"AttackDelay",
        @"attackMotion"     : @"AttackMotion",
        @"damageMotion"     : @"DamageMotion",
        @"damageTaken"      : @"DamageTaken",
        @"ai"               : @"Ai",
        @"monsterClass"     : @"Class",
        @"modes"            : @"Modes",
        @"mvpDrops"         : @"MvpDrops",
        @"drops"            : @"Drops",
    };
}

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"mvpDrops" : [RAMonsterDrop class],
        @"drops"    : [RAMonsterDrop class],
    };
}

+ (NSNumber *)aiFromString:(NSString *)string {
    static NSDictionary<NSString *, NSNumber *> *aiMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aiMap = @{
            @"01" : @(RAMonsterAi01),
            @"02" : @(RAMonsterAi02),
            @"03" : @(RAMonsterAi03),
            @"04" : @(RAMonsterAi04),
            @"05" : @(RAMonsterAi05),
            @"06" : @(RAMonsterAi06),
            @"07" : @(RAMonsterAi07),
            @"08" : @(RAMonsterAi08),
            @"09" : @(RAMonsterAi09),
            @"10" : @(RAMonsterAi10),
            @"11" : @(RAMonsterAi11),
            @"12" : @(RAMonsterAi12),
            @"13" : @(RAMonsterAi13),
            @"17" : @(RAMonsterAi17),
            @"19" : @(RAMonsterAi19),
            @"20" : @(RAMonsterAi20),
            @"21" : @(RAMonsterAi21),
            @"24" : @(RAMonsterAi24),
            @"25" : @(RAMonsterAi25),
            @"26" : @(RAMonsterAi26),
            @"27" : @(RAMonsterAi27),
        };
    });

    if (string == nil) {
        return nil;
    }

    NSNumber *ai = aiMap[string];
    return ai;
}

+ (NSNumber *)monsterClassFromString:(NSString *)string {
    static NSDictionary<NSString *, NSNumber *> *monsterClassMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        monsterClassMap = @{
            @"Normal"     .lowercaseString : @(RAMonsterClassNormal),
            @"Boss"       .lowercaseString : @(RAMonsterClassBoss),
            @"Guardian"   .lowercaseString : @(RAMonsterClassGuardian),
            @"Battlefield".lowercaseString : @(RAMonsterClassBattlefield),
            @"Event"      .lowercaseString : @(RAMonsterClassEvent),
        };
    });

    if (string == nil) {
        return nil;
    }

    NSNumber *monsterClass = monsterClassMap[string.lowercaseString];
    return monsterClass;
}

+ (RAMonsterMode)modesFromDictionary:(NSDictionary *)dictionary {
    static NSDictionary<NSString *, NSNumber *> *modeMap = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        modeMap = @{
            @"CanMove"          .lowercaseString : @(RAMonsterModeCanMove),
            @"Looter"           .lowercaseString : @(RAMonsterModeLooter),
            @"Aggressive"       .lowercaseString : @(RAMonsterModeAggressive),
            @"Assist"           .lowercaseString : @(RAMonsterModeAssist),
            @"CastSensorIdle"   .lowercaseString : @(RAMonsterModeCastSensorIdle),
            @"NoRandomWalk"     .lowercaseString : @(RAMonsterModeNoRandomWalk),
            @"NoCast"           .lowercaseString : @(RAMonsterModeNoCast),
            @"CanAttack"        .lowercaseString : @(RAMonsterModeCanAttack),
            @"CastSensorChase"  .lowercaseString : @(RAMonsterModeCastSensorChase),
            @"ChangeChase"      .lowercaseString : @(RAMonsterModeChangeChase),
            @"Angry"            .lowercaseString : @(RAMonsterModeAngry),
            @"ChangeTargetMelee".lowercaseString : @(RAMonsterModeChangeTargetMelee),
            @"ChangeTargetChase".lowercaseString : @(RAMonsterModeChangeTargetChase),
            @"TargetWeak"       .lowercaseString : @(RAMonsterModeTargetWeak),
            @"RandomTarget"     .lowercaseString : @(RAMonsterModeRandomTarget),
            @"IgnoreMelee"      .lowercaseString : @(RAMonsterModeIgnoreMelee),
            @"IgnoreMagic"      .lowercaseString : @(RAMonsterModeIgnoreMagic),
            @"IgnoreRanged"     .lowercaseString : @(RAMonsterModeIgnoreRanged),
            @"Mvp"              .lowercaseString : @(RAMonsterModeMvp),
            @"IgnoreMisc"       .lowercaseString : @(RAMonsterModeIgnoreMisc),
            @"KnockBackImmune"  .lowercaseString : @(RAMonsterModeKnockBackImmune),
            @"TeleportBlock"    .lowercaseString : @(RAMonsterModeTeleportBlock),
            @"FixedItemDrop"    .lowercaseString : @(RAMonsterModeFixedItemDrop),
            @"Detector"         .lowercaseString : @(RAMonsterModeDetector),
            @"StatusImmune"     .lowercaseString : @(RAMonsterModeStatusImmune),
            @"SkillImmune"      .lowercaseString : @(RAMonsterModeSkillImmune),
        };
    });

    if (dictionary == nil || dictionary.count == 0) {
        return 0;
    }

    __block RAMonsterMode modes = 0;
    [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
        NSNumber *mode = modeMap[key.lowercaseString];
        if (mode && obj.boolValue == YES) {
            modes |= mode.unsignedIntegerValue;
        }
    }];

    return modes;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _level = 1;
        _hp = 1;
        _sp = 1;
        _baseExp = 0;
        _jobExp = 0;
        _mvpExp = 0;
        _attack = 0;
        _attack2 = 0;
        _defense = 0;
        _magicDefense = 0;
        _resistance = 0;
        _magicResistance = 0;
        _strength = 1;
        _agility = 1;
        _vitality = 1;
        _intelligence = 1;
        _dexterity = 1;
        _luck = 1;
        _attackRange = 0;
        _skillRange = 0;
        _chaseRange = 0;
        _size = RASize.small;
        _race = RARace.formless;
        _raceGroups = 0;
        _element = RAElement.neutral;
        _elementLevel = 1;
        _walkSpeed = RAMonsterWalkSpeedNormal;
        _attackDelay = 0;
        _attackMotion = 0;
        _damageMotion = 0;
        _damageTaken = 100;
        _ai = RAMonsterAi06;
        _monsterClass = RAMonsterClassNormal;
        _modes = 0;
    }
    return self;
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *sizeName = dic[@"Size"];
    if (sizeName) {
        RASize *size = [RASize caseOfName:sizeName];
        if (size) {
            _size = size;
        }
    }

    NSString *raceName = dic[@"Race"];
    if (raceName) {
        RARace *race = [RARace caseOfName:raceName];
        if (race) {
            _race = race;
        }
    }

    NSDictionary<NSString *, NSNumber *> *raceGroupNames = dic[@"RaceGroups"];
    if (raceGroupNames) {
        NSMutableSet<RARaceGroup *> *raceGroups = [[NSMutableSet alloc] init];
        [raceGroupNames enumerateKeysAndObjectsUsingBlock:^(NSString *raceGroupName, NSNumber *value, BOOL *stop) {
            RARaceGroup *raceGroup = [RARaceGroup caseOfName:raceGroupName];
            if (raceGroup && value.boolValue == YES) {
                [raceGroups addObject:raceGroup];
            }
        }];
        _raceGroups = [raceGroups copy];
    }

    NSString *elementName = dic[@"Element"];
    if (elementName) {
        RAElement *element = [RAElement caseOfName:elementName];
        if (element) {
            _element = element;
        }
    }

    NSNumber *ai = [RAMonster aiFromString:dic[@"Ai"]];
    if (ai) {
        _ai = ai.integerValue;
    }

    NSNumber *monsterClass = [RAMonster monsterClassFromString:dic[@"Class"]];
    if (monsterClass) {
        _monsterClass = monsterClass.integerValue;
    }

    _modes = [RAMonster modesFromDictionary:dic[@"Modes"]];

    return YES;
}

@end

@implementation RAMonsterDrop

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
        @"item"                 : @"Item",
        @"rate"                 : @"Rate",
        @"stealProtected"       : @"StealProtected",
        @"randomOptionGroup"    : @"RandomOptionGroup",
        @"index"                : @"Index",
    };
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _stealProtected = false;
    }
    return self;
}

@end
