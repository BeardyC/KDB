\d .authTest
testAConvInt:{.qunit.assertEquals[.auth.toString[42];"42"; "Converted int"]};
testAConvSym:{.qunit.assertEquals[.auth.toString[`test]; "test"; "Converted symbol"]};
testAConvString:{.qunit.assertEquals[.auth.toString["test"];"test"; "String already converted"]};
testBAddUser1:{.qunit.assertEquals[.auth.add[`user1;`pass];1b; "Added user"]};
testBAddUser2:{.qunit.assertEquals[.auth.add[`user2;`pass];1b; "Added user"]};
testBAddUser3:{.qunit.assertEquals[.auth.add[`user3;`pass];1b; "Added User"]};

testBAddUserCount:{.qunit.assertEquals[.auth.count[];3; "Count Users"]};


testCAddUserDup:{.qunit.assertEquals[[.auth.add[`user1;`pass]];0b; "Duplicate"]};
testCAddUserDupCount:{.qunit.assertEquals[.auth.count[];3; "Count Users"]};

testDRemoveUser:{.qunit.assertEquals[.auth.remove[`user2];1b; "Removed user"]};
testDRemoveUserF:{.qunit.assertEquals[.auth.remove[`user2];0b; "No user found"]};
testECountUsers:{.qunit.assertEquals[.auth.count[];2; "Count Users"]};
\d .