import sys

if __name__ == "__main__":
  
    for line in sys.stdin:     
      valor_purpose = line.split(',')[3]
      valor_amount = line.split(',')[4]
      
      sys.stdout.write("{}\t{}\n".format(valor_purpose,valor_amount))
