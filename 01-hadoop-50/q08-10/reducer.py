import sys

if __name__ == '__main__':

    curkey = None
    maximo = 0.0
    promedio = 0.0
    n=1

    for line in sys.stdin:
        key, val = line.split("\t")
        val = float(val)

        if key == curkey:
            maximo = maximo + val
            promedio = maximo / n
                        
        else:
            
            if curkey is not None:                
                sys.stdout.write("{}\t{}\t{}\n".format(curkey, maximo, promedio))
            n=1
            curkey = key
            maximo = val
            promedio = maximo / n
        n=n+1
    sys.stdout.write("{}\t{}\t{}\n".format(curkey, maximo, promedio))