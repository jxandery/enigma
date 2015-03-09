require './lib/decrypt'

example = Decrypt.new
date = "030915"
key = "23814"
message = ".fq4f.17imiqcpy.1pkq6pr54tes3aes3aes3aq7ktc79.x84dj.1.cq1.c4fuxqfgc88sn77tdr2,dr2,dr2,d"
example.decrypting(date, message, key)

example1 = Decrypt.new
message = "7?vm0w2mapvsx45m6p mfz3txv564l4m1m7m04os0pxt4"
key = "41521"
date = "020315"
example1.decrypting(date, message, key)
