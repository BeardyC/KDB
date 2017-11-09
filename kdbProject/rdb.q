\l ./utils/log.q


port: read0 `:tport.q
user:"rdb";
password:"password";

orders:([] dates:();time:(); syms:();markets:(); bidprices:();askprices:();bidsizes:();asksizes:());

tp:`$ raze "::",raze port,":",user,":",password;
lg(`INFO;"connecting to tp ",-3!tp);
h:@[hopen;tp;{lg(`FATAL;"Connection error:",x);exit 1}]


.u.replay:{
	h"requestFH[]";
    orders:([] dates:();time:(); syms:();markets:(); bidprices:();askprices:();bidsizes:();asksizes:());
	i::0;
	-11!.u.L
	
 }

upd::{[tablename;data]

	i+:1;if[not i mod 100;
	lg(`VERBOSE;"Replayed ",string[i]," tp log batches")];
	tablename insert data;
 }
persistBlob:{
	`:ordersBlob set orders
 }
 
persistSplay:{
	`:ordersSplay set orders
 }

persistPartitioned:{
	{[year](`$":",string[year],"/ordersPartitioned/")set @[;`syms;`p#]`syms xasc delete dates from .Q.en[`:.]select from orders where dates=year}each distinct orders.dates
 }


 

