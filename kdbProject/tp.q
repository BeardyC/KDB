system"p 0W";
`:tport.q 0: string raze system"p"

\l ./utils/log.q
\l auth.q

conlog:([]time:`timestamp$();user:`$();handle:`int$(); contype:`$());
querylog:([]time:`timestamp$();user:`$();query:();querytype:`$());
auth:([]time:`timestamp$();user:`$();allowed:`boolean$());
orders:([] dates:();time:(); syms:();markets:(); bidprices:();askprices:();bidsizes:();asksizes:());

.u.L:`$":","./tpLog",string[.z.d],".kdbraw";
.u.L set ();
.u.l:hopen .u.L;

requestFH:{
	rdbH::first key .z.W;
	rdbH(.q.set;`.u.L;.u.L);

 }


.u.upd:{[tableName; tableData]
	i+:1;if[not i mod 20;
	lg(`VERBOSE;"Received 20 new packets of data on handle ",string .z.w);];
	tableName insert tableData;
	.u.l enlist (`upd;tableName;tableData);	
 }
 
if[() ~ key `:usersTable;
	`:usersTable set ([user:`$()] salt:`$(); password:())]

system"l usersTable";
.auth.add[`fh;`password]
.auth.add[`rdb;`password]


.z.pw:{[user;pass]
	accepted:$[.auth.encrypt[usersTable[user][`salt];pass]~usersTable[user][`password];1b;0b];
	`auth insert (.z.p;user;accepted);
 accepted}
 
.z.po:{[handle]
	lg(`INFO; "Connection on handle ",string[.z.w]," opened by ",string .z.u)
 }

.z.po:{[oldzpo;handle]
	(oldzpo[handle]);
	`conlog insert (.z.P; .z.u; handle; `open);
	`:cons.log upsert enlist (.z.P; .z.u; handle; `open)
 }.z.po

.z.ts:{
	lg(`VERBOSE;"Number of records in trade table : ", string count orders)

 }
.z.pc:{[handle]
	lg(`INFO;"Connection closed for handle: ", string handle);
	/0N!(`.z.pc;.z.P;"Connection closed for handle:",string oldhandle);-1""
 }
\t 5000
