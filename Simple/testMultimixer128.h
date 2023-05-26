
#include <stddef.h>
#include <stdint.h>
#include "align.h"

void Multimixer128field(const uint8_t *input, const uint8_t *key, const uint8_t *output, size_t inputLen);
void testMultimixer128(void);
