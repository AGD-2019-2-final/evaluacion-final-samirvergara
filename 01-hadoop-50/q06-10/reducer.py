import sys

if __name__ == '__main__':

    curkey = None
    maximo = 0.0
    minimo = 1000.0

    for line in sys.stdin:
        key, val = line.split("\t")
        val = float(val)

        if key == curkey:
            maximo = max(val,maximo)
            minimo = min(val,minimo)
        else:
            
            if curkey is not None:                
                sys.stdout.write("{}\t{}\t{}\n".format(curkey, maximo, minimo))
            curkey = key
            maximo = val
            minimo = val
    sys.stdout.write("{}\t{}\t{}\n".format(curkey, maximo, minimo))
