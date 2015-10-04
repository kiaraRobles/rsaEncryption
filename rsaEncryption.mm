#import <Foundation/Foundation.h>
#include <math.h>
#include <iostream>


int main(int argc, char *argv[]) {
	@autoreleasepool {

//[---------ENCODER--------]

// Person A selects two prime numbers	
//[------Private Key-------]
	NSInteger privateKeyValueP = 47;
	NSInteger privateKeyValueQ = 71;
	NSLog(@"p: %ld", (long)privateKeyValueP);
	NSLog(@"q: %ld", (long)privateKeyValueQ);

// Person A multiplies both numbers to get their "public key"
// Which they tell to person B and all of their Twitter friends
// Person A chooses a number 'e' which is prime relative to (p-1)(q-1)
//[-------Public Key-------]
	NSInteger publicKeyValueE  = 79;
	NSInteger publicKeyValuePQ = privateKeyValueP * privateKeyValueQ;
	NSLog(@"e: %ld", (long)publicKeyValueE);
	NSLog(@"p*q: %ld", (long)publicKeyValuePQ);
	
//[---Encryption Message---]
	NSInteger encryptionMessage = 35;

//[---Encrypted Message----]
//	M^e(mod N) = 35^7(mod 943) = 545
	NSInteger messagePow = pow(encryptionMessage,publicKeyValueE);
	NSInteger encryptedMessage = messagePow % publicKeyValuePQ;
	
//[---------DECODER--------]
// ed = 1(mod (p-1)(q-1))
// 7d = 1(mod 880) --> Extended Euler’s GCD algorithm OR Fermat’s Little theorem
	NSInteger decoderED = (privateKeyValueP - 1) * (privateKeyValueQ - 1);
	NSInteger decoderEDMod = decoderED % 1;
	NSLog(@"(p-1)(q-1): %ld", (long)decoderED);

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
	} while (c != 0);
	
	NSLog(@"GCD = %ld", (long)a);
	NSLog(@"Array = %@", nsNumberArray);
	
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
		
		
