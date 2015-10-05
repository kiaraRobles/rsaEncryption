#import <Foundation/Foundation.h>
#include <math.h>
#include <iostream>


int main(int argc, char *argv[]) {
	@autoreleasepool {

//[---Euclidean Algorithm---]	
	long long int orig_p = privateKeyValueP;
	long long int orig_q = privateKeyValueQ;
		
	long long int a = decoderED;
	long long int b = 0;
	long long int c = publicKeyValueE;
	long long int d = 0;
		
	NSNumber *aObj;
	NSNumber *bObj;
	NSNumber *cObj;
	NSNumber *dObj;
		
	NSInteger count = 0;
	NSMutableArray *nsNumberArray = [[NSMutableArray alloc]init];
	do {
		d = a % c;
		b = (a - d)/c;
		NSLog(@"a = %ld", (long)a);
		NSLog(@"b = %ld", (long)b);
		NSLog(@"c = %ld", (long)c);
		NSLog(@"d = %ld", (long)d);
		aObj = [NSNumber numberWithInteger: a];
		bObj = [NSNumber numberWithInteger: b];
		cObj = [NSNumber numberWithInteger: c];
		dObj = [NSNumber numberWithInteger: d];
		[nsNumberArray addObject:aObj];
		[nsNumberArray addObject:bObj];
		[nsNumberArray addObject:cObj];
		[nsNumberArray addObject:dObj];
		a = c;
		c = d;
		count++;
	} while (c != 0);
		
	NSLog(@"GCD = %ld", (long)a);
	NSLog(@"Array = %@", nsNumberArray);
	NSLog(@"count = %ld", (long)count);
		
		
	for (NSUInteger i = 0; i < count; i++) {
		
		aObj = [nsNumberArray lastObject];
		a = [aObj intValue];
		[nsNumberArray removeLastObject];
		bObj = [nsNumberArray lastObject];
		b = [bObj intValue];
		[nsNumberArray removeLastObject];
		cObj = [nsNumberArray lastObject];
		c = [cObj intValue];
		[nsNumberArray removeLastObject];
		dObj = [nsNumberArray lastObject];
		d = [dObj intValue];
		[nsNumberArray removeLastObject];
		NSLog(@"a = %llu, b = %llu, c = %llu, d = %llu", a, b, c, d);
	}

	}
}
		
