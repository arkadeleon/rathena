//
//  RADatabase.m
//  rAthena
//
//  Created by Leon Li on 2023/6/28.
//

#import "RADatabase.h"

@interface RADatabaseRecordFieldsBuilder ()

@property (nonatomic) NSMutableArray<RADatabaseRecordField *> *recordFields;

@end

@implementation RADatabase

- (NSString *)name {
    return @"";
}

- (void)loadWithCompletionHandler:(void (^)(NSArray<RADatabaseRecord *> *))completionHandler {
    completionHandler(@[]);
}

@end

@implementation RADatabaseRecord

- (NSInteger)recordID {
    return 0;
}

- (NSString *)recordTitle {
    return @"";
}

- (void)buildRecordFieldsWithBuilder:(RADatabaseRecordFieldsBuilder *)builder {
}

@end

@implementation RADatabaseRecordFieldsBuilder

- (instancetype)init {
    self = [super init];
    if (self) {
        _recordFields = [NSMutableArray array];
    }
    return self;
}

- (void)addRecordFieldWithName:(NSString *)name stringValue:(NSString *)stringValue {
    RADatabaseRecordFieldValue *value = [[RADatabaseRecordFieldValue alloc] initWithString:stringValue];
    RADatabaseRecordField *field = [[RADatabaseRecordField alloc] initWithName:name value:value];
    [self.recordFields addObject:field];
}

- (void)addRecordFieldWithName:(NSString *)name stringArrayValue:(NSArray<NSString *> *)stringArrayValue {
    RADatabaseRecordFieldValue *value = [[RADatabaseRecordFieldValue alloc] initWithStringArray:stringArrayValue];
    RADatabaseRecordField *field = [[RADatabaseRecordField alloc] initWithName:name value:value];
    [self.recordFields addObject:field];
}

- (NSArray<RADatabaseRecordField *> *)build {
    return [self.recordFields copy];
}

@end

@implementation RADatabaseRecordField

- (instancetype)initWithName:(NSString *)name value:(RADatabaseRecordFieldValue *)value {
    self = [super init];
    if (self) {
        _name = [name copy];
        _value = value;
    }
    return self;
}

@end

@implementation RADatabaseRecordFieldValue

- (instancetype)initWithString:(NSString *)string {
    self = [super init];
    if (self) {
        _type = RADatabaseRecordFieldValueTypeString;
        _string = [string copy];
    }
    return self;
}

- (instancetype)initWithStringArray:(NSArray<NSString *> *)stringArray {
    self = [super init];
    if (self) {
        _type = RADatabaseRecordFieldValueTypeStringArray;
        _stringArray = [stringArray copy];
    }
    return self;
}

@end
