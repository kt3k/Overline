//
// Created by yaakaito on 2013/01/04.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSSet+Enumeration.h"


@implementation NSSet (Enumeration)

- (void)each:(void (^)(id))block {
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        block(obj);
    }];
}

- (NSSet *)map:(id (^)(id))block {
    return [self mappedSetUsingBlock:block];
}

- (NSSet *)mappedSetUsingBlock:(id (^)(id))block {
    NSMutableSet *result = [NSMutableSet set];
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        id o = block(obj);
        if (o) {
            [result addObject:o];
        }
    }];
    return result;
}

- (id)reduce:(id (^)(id, id))block memo:(id)memo {
    return [self reducedObjectByBlock:block memo:memo];
}

- (id)reducedObjectByBlock:(id (^)(id, id))block memo:(id)memo {
    __block id reducedObject = memo;
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        reducedObject = block(reducedObject, obj);
    }];
    return reducedObject;
}

- (NSSet *)filteredSetUsingBlock:(BOOL (^)(id))block opposite:(BOOL)opposite {
    NSMutableSet *filteredSet = [NSMutableSet set];
    [self enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        BOOL r = block(obj);
        if (r == !opposite) {
            [filteredSet addObject:obj];
        }
    }];
    return filteredSet;
}
- (NSSet *)filter:(BOOL (^)(id))block {
    return [self filteredSetUsingBlock:block];
}

- (NSSet *)filteredSetUsingBlock:(BOOL (^)(id))block {
    return [self filteredSetUsingBlock:block opposite:NO];
}

- (NSSet *)reject:(BOOL (^)(id))block {
    return [self rejectedSetUsingBlock:block];
}

- (NSSet *)rejectedSetUsingBlock:(BOOL (^)(id))block {
    return [self filteredSetUsingBlock:block opposite:YES];
}
@end