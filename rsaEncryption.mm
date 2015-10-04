#import <Foundation/Foundation.h>
#include <math.h>
#include <iostream>


int main(int argc, char *argv[]) {
	@autoreleasepool {

//[---------ENCODER--------]

// Person A selects two prime numbers	
//[------Private Key-------]
	long long int privateKeyValueP = 23;
	long long int privateKeyValueQ = 41;
	NSLog(@"prime1 = %lu", privateKeyValueP);
	NSLog(@"prime2 = %lu", privateKeyValueQ);
	
// Person A multiplies both numbers to get their "public key"
// Which they tell to person B and all of their Twitter friends
// Person A chooses a number 'e' which is prime relative to (p-1)(q-1)
//[-------Public Key-------]
	long long int publicKeyValueE  = 7;
	NSLog(@"relativePrime = %lu", publicKeyValueE);
	long long int publicKeyValuePQ = privateKeyValueP * privateKeyValueQ;
	
//[---Encryption Message---]
	long long int encryptionMessage = 35;

//[---Encrypted Message----]
//	M^e(mod N) = 35^7(mod 943) = 545
	long long int messagePow = pow(encryptionMessage,publicKeyValueE);
	long long int encryptedMessage = messagePow % publicKeyValuePQ;
	NSLog(@"encryptedMessage = %lu", encryptedMessage);
	
	
//[---------DECODER--------]
// ed = 1(mod (p-1)(q-1))
// 7d = 1(mod 880) --> Extended Euler’s GCD algorithm OR Fermat’s Little theorem
	long long int decoderED = (privateKeyValueP - 1) * (privateKeyValueQ - 1);
	long long int decoderEDMod = decoderED % 1;

	
	NSUInteger d = 1;
	NSUInteger dd = 0;
	for (NSUInteger i = 1; d < decoderED; i++) {
		d = (i * decoderED + 1) / publicKeyValueE;
		if (d * publicKeyValueE == (i * decoderED + 1)) {
			NSLog(@"i = %lu", i);
			NSLog(@"d = %lu", d);
			dd = d;
		}
	}
	
//[---Decrypted Message----]
//	M^e(mod N) = 35^7(mod 943) = 545
	
	NSNumber *numObj;
	long long int messagePow2 = 0;
	NSMutableArray *nsNumberArray = [[NSMutableArray alloc]init];
	
	
	// Error at 545^8
	for (NSUInteger i = 2; i < encryptedMessage; i++){
		i--;
		messagePow2 = pow(encryptedMessage,i);
		messagePow2 = messagePow2 % publicKeyValuePQ;
		
		NSLog(@"messagePow2 = %llu", messagePow2);
		NSLog(@"%lu", i);
		i = i * 2;
	}

	}
}
		
