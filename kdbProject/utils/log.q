\c 25 200
lg:{-1 string[.z.p]," ",string[x 0]," ",x 1;x 1}


//let everyone log in TODO not this!
//Assume that ` is not a valid character in the username, and use it to split the process name from the username if it exists: `$("username"; "username`processname")
.z.pw:{[user;pass]lg(`INFO;"new connection request from ",ssr[string user;"`";":"]," on handle ",string .z.w);
	1b}
