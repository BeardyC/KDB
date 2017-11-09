# KDB Ticker Plant

Implementing a feed handler in Java to interface with a ticker plant in KDB+.

Build a user verification system to restrict user access on entry.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Software: KDB+, Java

OS: Windows/Unix

### Installing
A step by step series of examples that tell you have to get a development env running

Extract to home directory

#### Windows
```
C:\Users\User
```
#### Unix
```
/home/user
```
### Setup

Navigate to the installation folder.
Start the Ticker Plant with -S flag to deal with pseudorandom problems
```
q tp.q -S number
```
Start the RDB 
```
q rdb.q
```
To start the Feed Handler navigate to 
```
.\kdbFH\src\main\java 
```
```
./kdbFH/src/main/java
```
Start the Java application by using one of the two commands:
##### Windows
```
java -cp . jc.m3.App
```
##### Unix
```
java jc/m3/App
```
Login with preset Feed Handler credentialsr:
```
username: fh
password: password
```

Upon completing this step all 3 instances are connected.

## API

### perms.q

This script gives us the ability to manage users that can connect to the Ticker Plant, this was developed to showcase the modified versions of the z functions to control and monitor user access. Implementing this in a private namespace, .perm, keeps the functions from accidental or unwanted use.

This allows the functions of adding, removing, editing users **within the tp process** since it's loaded on start.

##### .perm Functions:

###### Add User

```
.perm.add[`user;`password]
```
###### Edit User 

```
.perm.edit[`user; new `password]
```
###### Remove User

```
.perm.remove[`user]
```


##### Utils
Salting - returns a random Salt to be used with the password for encryption. 
```
.perm.salting[]
```
Encrypt - Uses MD5 hashing to encrypt the salted password so it's safe for storage.
```
.perm.encrypt[salt;password] 
```

### tp.q
.u.upd - Called by the Java Feed Handler once connected to send over the generated data. It then both saves the data in a table and also saves it in the **logfile** which the RDB can request to replay back from.

```
.u.upd[tableName; tableData]
```

### rdb.q
.u.replay - Requests the logfile handle from the tickerplant and then replays the logfile contents to store them in memory.

```
.u.replay[]
```

persistX - Saves in memory database to disk in different formats.
```
persistBlob[]
persistSplay[]
persistPartitioned[]
```

## Running the tests
Using QUnit - KDB Unit Testing Framework to test my .perms.q script

A script, testcomp.q, is included that can be executed that will load all the required scripts and run the tests. 
```
q testcomp.q
```
All tests are contained in permsTest.q, to add any further testing simply append tests to this file.

##### Sample output
```
status name                            result actual expected msg                        time mem  maxTime maxMem namespace
----------------------------------------------------------------------------------------------------------------------------
pass   .permsTest.testAConvInt         "42"   "42"   "42"     "Converted int"            0    2816 0W      0W     .permsTest
pass   .permsTest.testAConvStrinfg      "test" "test" "test"   "String already converted" 0    2816 0W      0W     .permsTest
pass   .permsTest.testAConvSym         "test" "test" "test"   "Converted symbol"         0    2816 0W      0W     .permsTest
pass   .permsTest.testBAddUser1        1b     1b     1b       "Added user"               0    8736 0W      0W     .permsTest
pass   .permsTest.testBAddUser2        1b     1b     1b       "Added user"               8    8656 0W      0W     .permsTest
pass   .permsTest.testBAddUser3        1b     1b     1b       "Added User"               7    8672 0W      0W     .permsTest
pass   .permsTest.testBAddUserCount    3      3      3        "Count Users"              0    2816 0W      0W     .permsTest
pass   .permsTest.testCAddUserDup      0b     0b     0b       "Duplicate"                9    8672 0W      0W     .permsTest
pass   .permsTest.testCAddUserDupCount 3      3      3        "Count Users"              0    2880 0W      0W     .permsTest
pass   .permsTest.testDRemoveUser      1b     1b     1b       "Removed user"             1    3616 0W      0W     .permsTest
pass   .permsTest.testDRemoveUserF     0b     0b     0b       "No user found"            7    2816 0W      0W     .permsTest
pass   .permsTest.testECountUsers      2      2      2        "Count Users"              0    2816 0W      0W     .permsTest
```

## Built With

* [qUnit](http://www.timestored.com/kdb-guides/kdb-regression-unit-tests) - Test Framework Used

## Authors

* **Jose Costa** 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE) file for details

## Acknowledgments

* David Hodgins


