import sys

if __name__ == "__main__":
  
    for line in sys.stdin:
        letra = line.split(',')[0]
        valor = int(line.split(',')[1])
        sys.stdout.write("{}\t{}\t{}\n".format(valor,letra,valor))