#include <assert.h>
#include <inttypes.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "config.h"
#include "timing.h"
#include "testMultimixer156.h"
#define Many 1
typedef cycles_t (* measurePerf)(cycles_t, unsigned int);


#define xstr(s) str(s)
#define str(s) #s



static inline uint64_t now(void)
{
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC,&ts);
    return (uint64_t) ts.tv_sec * 1000000000 + ts.tv_nsec;
}


static uint64_t measureMultimixerNeon(uint64_t dtMin, unsigned int inputLen){
    
    ALIGN(64) uint8_t input[inputLen];
    ALIGN(64) uint8_t output[inputLen];
    ALIGN(64) uint8_t key[inputLen];
    memset(key, 0xA5, sizeof(key));
    memset(input, 0x3B, sizeof(input));
    {
        dtMin = now();
	    Multimixer156field(input, key, output, (size_t)inputLen);
        dtMin=now()-dtMin;
    }
}



void testMultimixerOne( void )
{
    
    uint32_t len;    
    uint64_t calibration = 0;
    int length[] = {1,2,4,8,16,32,64,100,128,200,256,1024};
    for(len=0; len <= 11; len=len+1) {
        uint64_t MinT = 1000000000;
        for(int i = 0; i <=1000000; i++){
            calibration = measureMultimixerNeon(calibration,32*length[len]);// 32*len);
            if (calibration < MinT){
                MinT=calibration;
                }
        }
        printf("%8d bytes: %9"PRId64" %s, %6.3f %s/byte\n", 32*length[len], MinT, getTimerUnit(), MinT*1.0/(32*length[len]), getTimerUnit());
    }
}



void testMultimixer156(void)
{
    testMultimixerOne();
}



