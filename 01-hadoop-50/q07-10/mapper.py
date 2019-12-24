import sys

if __name__ == "__main__":
    for line in sys.stdin:
        clave = line.split('   ')[0]
        fecha = line.split('   ')[1]
        valor = line.split('   ')[2]
        sys.stdout.write("{}\t{}\t{}".format(clave,fecha,valor))