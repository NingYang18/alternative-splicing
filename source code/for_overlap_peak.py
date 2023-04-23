
#!/usr/bin/env python3
import sys
import multiprocessing
import time

def find_overlap(peak:tuple,in1,out):
    outfile=open(out,'a')
    infile=open(in1,'r')
    for line in infile:
        Line=line.split('\t')
        if peak[0] == Line[0]:
            if peak[2] >= int(Line[1]) and peak[1] <= int(Line[2]):
                peak_str = list(map(str,peak))
                outfile.write('\t'.join(peak_str)+'\t'+line)
    outfile.close()
    infile.close()

if __name__ == '__main__':

    pool=multiprocessing.Pool(8)
    infile1=open(sys.argv[1],'r')
    #infile2=open(sys.argv[2],'r')
    #outfile=open(sys.argv[3],'w')

    start=time.time()
    for line1 in infile1:
        #print(line1)
        Line1=line1.split('\t')
        peak1=(Line1[0],int(Line1[1]),int(Line1[2]),Line1[8])
        #print(peak1)
        pool.apply_async(func=find_overlap,args=(peak1,sys.argv[2],sys.argv[3]))
    #outfile.close()
    end=time.time()
    print(str(end-start))
    #outfile1.close()
    infile1.close()
    pool.close()
    pool.join()

