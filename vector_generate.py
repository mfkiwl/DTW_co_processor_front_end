import numpy as np
import matplotlib.pyplot as plt
import random
from dtw import dtw

def distance(x,y):
    return np.abs(x[0]-y[0])+np.abs(x[1]-y[1])+np.abs(x[2]-y[2])

i = 0
f = open("vector_result.out","w")     
fy = open("vector_input.out","w")
fx = open("vector_memory.out","w")
while 1:
    x = np.zeros(shape=(20,3))
    y = np.zeros(shape=(20,3)) 
    j=0
    while 1:
        x1 = random.randint(-512,511)
        x2 = random.randint(-512,511)
        x3 = random.randint(-512,511)
        y1 = x1 + random.randint(-512,511)
        y2 = x2 + random.randint(-512,511)
        y3 = x3 + random.randint(-512,511)
        if(  (y1 >=-512)&(y1 <=511) & (y2 >=-512)&(y2 <=511) & (y3 >=-512)&(y3 <=511)  ):
            x[j] = [x1,x2,x3]
            y[j] = [y1,y2,y3]
            if(j==19):break
            j=j+1
    d, cost_matrix, acc_cost_matrix, path = dtw(x, y, dist=distance)
    if(np.abs(d)<2**15):
        i = i+1
        if(i==11):break
        for k in range(20):
            d0=int(x[k,0])
            d1=int(x[k,1])
            d2=int(x[k,2])
            if(d0<0):
                d0 = 1024+d0
            if(d1<0):
                d1 = 1024+d1
            if(d2<0):
                d2 = 1024+d2
            b0=bin(d0)
            b1=bin(d1)
            b2=bin(d2)
            b=b0[2:].zfill(10) + b1[2:].zfill(10) + b2[2:].zfill(10)
            h=hex(int(b,2))
            fx.write(h[2:].zfill(8)+" ")
        fx.write("\n")
        for k in range(20):
            d0=int(y[k,0])
            d1=int(y[k,1])
            d2=int(y[k,2])
            if(d0<0):
                d0 = 1024+d0
            if(d1<0):
                d1 = 1024+d1
            if(d2<0):
                d2 = 1024+d2
            b0=bin(d0)
            b1=bin(d1)
            b2=bin(d2)
            b=b0[2:].zfill(10) + b1[2:].zfill(10) + b2[2:].zfill(10)
            h=hex(int(b,2))
            fy.write(h[2:].zfill(8)+" ")
        fy.write("\n")
        
        #print(d)      
        plt.imshow(acc_cost_matrix.T, origin='lower', cmap='gray', interpolation='nearest')
        plt.plot(path[0], path[1], 'w')
        plt.show() 
        
        xx=hex(int(path[0][-1]))
        xx=xx[2:].zfill(2)
        yy=hex(int(path[1][-1]))
        yy=yy[2:].zfill(2)
        rr=hex(int(d))
        rr=rr[2:].zfill(4)
        f.write(xx+yy+rr+" ")
        for l in range(len(path[0])-1):
            xx=hex(int(path[0][-l-2]))
            xx=xx[2:].zfill(2)
            yy=hex(int(path[1][-l-2]))
            yy=yy[2:].zfill(2)
            f.write(xx+yy+"0000"+" ")
        f.write("\n")
f.close()
fx.close()
fy.close()
    



