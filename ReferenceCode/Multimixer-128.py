# -*- coding: utf-8 -*-

# The following part is used to generate key and message

import random

def rand_key(p):
   
    # Variable to store the string
    key1 = ""
 
    # Loop to find the string of desired length
    for i in range(p):
         
        # randint function to generate 0, 1 randomly and converting the result into str
        tem = str(random.randint(0,1))
 
        # Concatenation the random 0, 1 to the final result
        key1 += tem
         
    return(key1)
 
#This is the block function for Multimixer-128

def Int_multimix(M,K):
    # Define the number of blocks and then Split the message and the key into blocks of size 256
    # Store the split msg blocks and key blocks in the array Msg_blks, Key_blks respectively
    Block_num = len(M)//256
    Msg_blks = []
    Key_blks = []
    for i in range(Block_num):
        Msg_blk = M[256*i: 256*(i+1)]
        Key_blk = K[256*i: 256*(i+1)]
        Msg_blks.append(Msg_blk)
        Key_blks.append(Key_blk)     
    
    # For each block, divide the messages and keys into 32 bit chunks to obtain the A,B,P and Q
    Blk_reslts = []
    for i in range(len(Msg_blks)):
        # X_i's are the first parts of the messages, Y_i's are the second part, similar for H_i and K_i. 
        
        X_0 = int(Msg_blks[i][0:32],2)
        X_1 = int(Msg_blks[i][32:64],2)
        X_2 = int(Msg_blks[i][64:96],2)
        X_3 = int(Msg_blks[i][96:128],2)

        Y_0 = int(Msg_blks[i][128:160],2)
        Y_1 = int(Msg_blks[i][160:192],2)
        Y_2 = int(Msg_blks[i][192:224],2)
        Y_3 = int(Msg_blks[i][224:256],2)

        H_0 = int(Key_blks[i][0:32],2)
        H_1 = int(Key_blks[i][32:64],2)
        H_2 = int(Key_blks[i][64:96],2)
        H_3 = int(Key_blks[i][96:128],2)
        
        K_0 = int(Key_blks[i][128:160],2)
        K_1 = int(Key_blks[i][160:192],2)
        K_2 = int(Key_blks[i][192:224],2)
        K_3 = int(Key_blks[i][224:256],2)
        #A_i and B_i are the inputs to the block function (after addition with the corresponding key bits)
        A_0 =(X_0+H_0)%(2**32)
        A_1 =(X_1+H_1)%(2**32)
        A_2 =(X_2+H_2)%(2**32)
        A_3 =(X_3+H_3)%(2**32)
        
        B_0 =(Y_0+K_0)%(2**32)
        B_1 =(Y_1+K_1)%(2**32)
        B_2 =(Y_2+K_2)%(2**32)
        B_3 =(Y_3+K_3)%(2**32)
        # Compute P_i and Q_i from A_i, B_i 
        P_0 = (A_0+A_1+A_2)%(2**32)
        P_1 = (A_1+A_2+A_3)%(2**32)
        P_2 = (A_2+A_3+A_0)%(2**32)
        P_3 = (A_3+A_0+A_1)%(2**32)

        Q_0 = (B_1+B_2+B_3)%(2**32)
        Q_1 = (B_2+B_3+B_0)%(2**32)
        Q_2 = (B_3+B_0+B_1)%(2**32)
        Q_3 = (B_0+B_1+B_2)%(2**32)
        # the block function computes the 8 multiplications
        # Results for each block are stored as 8-tuple in the array Blk_reslts
        Blk_res = (A_0*B_0, A_1*B_1, A_2*B_2, A_3*B_3, P_0*Q_0, P_1*Q_1, P_2*Q_2, P_3*Q_3)
        Blk_reslts.append(Blk_res)
    # res finally adds the results of each block co-ordinatewise and then converts it back to a string
    res =""
    for j in range(8):
        temp = '{:064b}'.format(sum(i[j] for i in Blk_reslts)%(2**(64)))
        res += temp
    
#print(Blk_reslts)

    return(res)


#256 = block size of Multimixer-128


l = int(input("Enter message Length:   "))            

Msg = rand_key(l*256)
Key = rand_key(l*256)

print(Int_multimix(Msg, Key))
