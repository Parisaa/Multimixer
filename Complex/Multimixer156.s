.text
.align 8
.global Multimixer156field
.type	Multimixer156field, %function;

Multimixer156field:
	vmov.u64	q0, #0
	vmov.u64	q1, #0
	vmov.u64	q2, #0
	vmov.u64	q3, #0
	subs		r3, r3, #32
	bcc		.Lloop3_done
	
.Lloop3Once:
	
	vld1.32	{q4,q5}, [r1]!				// MESSAGE ADDRESS is held by r1
	vld1.32	{q6,q7}, [r0]!				// KEY ADDRESS is held by r0
	vadd.u32	q4, q4, q6   				// q4 contains X0,X2,Y1,Y3
	vadd.u32	q5, q5, q7   				// q5 contains X1,X3,Y2,Y0
	
	
	vadd.u32	q6, q4, q5				// q6 contains X0+X1,X2+X3,Y1+Y2,Y0+Y3
	vrev64.32	q7, q5					// q7 contains X3,X1,Y0,Y2
	vadd.u32	q7, q7, q4				// q7 contains X0+X3,X2+X1,Y0+Y1,Y2+Y3
	vrev64.32	q8, q6					// q8 contains X2+X3,X0+X1,Y0+Y3,Y1+Y2
	
	vadd.u32	q8, q8, q6				// q8 contains X0+X1+X2+X3,X0+X1+X2+X3,Y0+Y1+Y2+Y3,Y0+Y1+Y2+Y3
	vadd.u32	q6, q8, q6				// q6 contains 2X0+2X1+X2+X3,X0+X1+2X2+2X3,Y0+2Y1+2Y2+Y3,2Y0+Y1+Y2+2Y3
	vadd.u32	q7, q8, q7				// q7 contains 2X0+X1+X2+2X3,X0+2X1+2X2+X3,2Y0+2Y1+Y2+Y3,Y0+Y1+2Y2+2Y3
	vadd.u32	q8, q4, q7				// q8 contains 3X0+X1+X2+2X3,X0+2X1+3X2+X3,2Y0+3Y1+Y2+Y3,Y0+Y1+2Y2+3Y3:P1,P3,Q1,Q3
	vadd.u32	q9, q5, q6				// q9 contains 2X0+3X1+X2+X3,X0+X1+2X2+3X3,Y0+2Y1+3Y2+Y3,3Y0+Y1+Y2+2Y3:P2,P0,Q2,Q0	
	
	vswp		d9,d10					// q4 contains X0,X2,X1,X3  q5 contains Y0,Y2,Y1,Y3
	vadd.u32	q7,q4,q5				// q7 contains X0+Y0,X2+Y2,X1+Y1,X3+Y3
	
	vshr.u32	q6,q7, #29
	vsli.u32	q3, q4, #3
	vadd.u32	q5,q6,q5				// q5 contians Y0',Y2',Y1',Y3'  q7 contians X0',X2',X1',X3'
	
	vmlal.u32	q0, d10, d14				// q0 contains X0'Y0',X2'Y2' 
	vmlal.u32	q1, d11, d15				// q1 contains X1'Y1',X3'Y3'
	vmlal.u32	q2, d16, d17				// q2 contains P1Q1,P3Q3  P1,P3,Q1,Q3
	vmlal.u32	q3, d18, d19				// q3 contains P2Q2,P0Q0  P2,P0,Q2,Q0
	
	subs		r3, r3, #32
	bcc		   .Lloop3_done

.Lloop3:

	vld1.32	{q4,q5}, [r1]!				// MESSAGE ADDRESS is held by r1
	vld1.32	{q6,q7}, [r0]!				// KEY ADDRESS is held by r0
	vadd.u32	q4, q4, q6   				// q4 contains X0,X2,Y1,Y3
	vadd.u32	q5, q5, q7   				// q5 contains X1,X3,Y2,Y0
	
	
	vadd.u32	q6, q4, q5				// q6 contains X0+X1,X2+X3,Y1+Y2,Y0+Y3
	vrev64.32	q7, q5					// q7 contains X3,X1,Y0,Y2
	vadd.u32	q7, q7, q4				// q7 contains X0+X3,X2+X1,Y0+Y1,Y2+Y3
	vrev64.32	q8, q6					// q8 contains X2+X3,X0+X1,Y0+Y3,Y1+Y2
	
	vadd.u32	q8, q8, q6				// q8 contains X0+X1+X2+X3,X0+X1+X2+X3,Y0+Y1+Y2+Y3,Y0+Y1+Y2+Y3
	vadd.u32	q6, q8, q6				// q6 contains 2X0+2X1+X2+X3,X0+X1+2X2+2X3,Y0+2Y1+2Y2+Y3,2Y0+Y1+Y2+2Y3
	vadd.u32	q7, q8, q7				// q7 contains 2X0+X1+X2+2X3,X0+2X1+2X2+X3,2Y0+2Y1+Y2+Y3,Y0+Y1+2Y2+2Y3
	vadd.u32	q8, q4, q7				// q8 contains 3X0+X1+X2+2X3,X0+2X1+3X2+X3,2Y0+3Y1+Y2+Y3,Y0+Y1+2Y2+3Y3:P1,P3,Q1,Q3
	vadd.u32	q9, q5, q6				// q9 contains 2X0+3X1+X2+X3,X0+X1+2X2+3X3,Y0+2Y1+3Y2+Y3,3Y0+Y1+Y2+2Y3:P2,P0,Q2,Q0	
	
	vswp		d9,d10					// q4 contains X0,X2,X1,X3  q5 contains Y0,Y2,Y1,Y3
	vadd.u32	q7,q4,q5				// q7 contains X0+Y0,X2+Y2,X1+Y1,X3+Y3
	vshr.u32	q6,q7, #29
	vsli.u32	q6,q7, #3
	vadd.u32	q5,q6,q5				// q5 contians Y0',Y2',Y1',Y3'  q7 contians X0',X2',X1',X3'
	
	
	
	vmlal.u32	q0, d10, d14				// q0 contains X0'Y0',X2'Y2' 
	vmlal.u32	q1, d11, d15				// q1 contains X1'Y1',X3'Y3'
	vmlal.u32	q2, d16, d17				// q2 contains P1Q1,P3Q3  P1,P3,Q1,Q3
	vmlal.u32	q3, d18, d19				// q3 contains P2Q2,P0Q0  P2,P0,Q2,Q0

	subs		r3, r3, #32
	bcs     	.Lloop3
		
.Lloop3_done:

	vmov.64		d8, d1
	vmov.64		d1, d2
	vmov.64		d2, d8
	vmov.64		d8, d5
	vmov.64		d5, d4
	vmov.64		d4, d7
	vmov.64		d7, d8
	vst1.8		{q0,q1}, [r2]!				// q0: X0Y0,X1Y1  q1:X2Y2,X3Y3
	vst1.8		{q2,q3}, [r2]!				// q2: P0Q0,P1Q1  q3:P2Q2,P3Q3	
	
	bx		lr

