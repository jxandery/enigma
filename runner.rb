require './lib/decrypt'
require './lib/encrypt'

example = Decrypt.new
date = "030915"
key = "23814"
message = ".fq4f.17imiqcpy.1pkq6pr54tes3aes3aes3aq7ktc79.x84dj.1.cq1.c4fuxqfgc88sn77tdr2,dr2,dr2,d"
puts example.decrypt(date, message, key)

example1 = Decrypt.new
message = "7vm0w2mapvsx45m6p mfz3txv564l4m1m7m04os0pxt4"
key = "41521"
date = "020315"
puts example1.decrypt(date, message, key)

example2 = Encrypt.new
message = "oh, happy day ..end.."
key = "41521"
date = "030915"
puts "Created 'encrypted.txt' with the key #{example2.key} and date #{date}. The encrypted message is #{example2.encrypt(date, message)}."

example3 = Decrypt.new
message = "7vm0w2mapvsx45m6p mfz3txv564l4m1m7m04os0pxt4"
key = "41521"
date = "020315"
puts "Created 'decrypted.txt' with the key #{key} and date #{date}. The decrypted message is #{example3.decrypt(date, message, key)}"

example0 = Decrypt.new
message0 = "7yaxl8tx959xy58x756 t4v"
key0 = "41521"
date0 = "020315"
puts "Created 'decrypted.txt' with the key #{key0} and date #{date0}. The decrypted message is #{example0.decrypt(date0, message0, key0)}"

example_no_more = Decrypt.new
message_no_more = "zyoxsr4c9os09onyp4syj"
key_no_more = "41521"
date_no_more = "020315"
puts "Created 'decrypted.txt' with the key #{key_no_more} and date #{date_no_more}. The decrypted message is #{example_no_more.decrypt(date_no_more, message_no_more, key_no_more)}"
