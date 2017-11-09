
usersTable:([]user:`$();salt:`$();password:());
.auth.toString:{[x] $[10h=abs type x;x;string x]}
//Needs to gen a salt outside of Q as its pseudorandom!
.auth.salting:{[] 
	salt::();
	({salt,:upper $[x<27;rand" ";string rand 10]} each (25?37));
	`$salt
 }; 
 

.auth.encrypt:{[salt;password] 
	md5 raze .auth.toString password,salt
 }
 
 
.auth.add:{[userx;password]
	rndSalt:.auth.salting[];
	$[count select from usersTable where user=userx;
		[0N! "User already exists";0b];
		[0N!"Successfully added user";
			`usersTable upsert (userx;rndSalt;.auth.encrypt[rndSalt;password]);
			1b
			]] 
 }

 
.auth.remove:{[x]
	$[count select from usersTable where user=x;
		[0N! raze "Successfully removed ", string x," from the users table";
			delete from `usersTable where user=x;
			1b];
		[0N! "User doesn't exist";0b]]
			
	
 }
 
.auth.changepassword:{[userx;password]
	$[count select from usersTable where user=userx;
		[0N! "Password changed";
			delete from `usersTable where user=userx;
			rndSalt:.auth.salting[];
			`usersTable upsert (userx;rndSalt;.auth.encrypt[rndSalt;password]);];
		[0N!"User doesn't exist";]]
			
 }
 
.auth.count:{[]count usersTable}