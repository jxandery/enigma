require './lib/decrypt'
require './lib/encrypt'

example = Decrypt.new
date = "030915"
key = "23814"
message = ".fq4f.17imiqcpy.1pkq6pr54tes3aes3aes3aq7ktc79.x84dj.1.cq1.c4fuxqfgc88sn77tdr2,dr2,dr2,d"
puts example.decrypt(date, message, key)

example2 = Encrypt.new
message2 = "oh, happy day ..end.."
date2 = "030915"
puts "Created 'encrypted.txt' with the key #{example2.key} and date #{date2}. The encrypted message is #{example2.encrypt(date2, message2)}"

example3 = Decrypt.new
date3 = "030915"
key3 = "88340"
message3 = "5o9dyhmvceagce8evuaep"
puts example3.decrypt(date3, message3, key3)

example4 = Encrypt.new
message4 = "we all need to get some korean bbq at daegee ..end.."
date4 = "030915"
puts "Created 'encrypted.txt' with the key #{example4.key} and date #{date4}. The encrypted message is #{example4.encrypt(date4, message4)}"
