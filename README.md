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
Salting - returns a random Salt to be used with the password for encryption, 
```
.perm.salting[]
```
Encrypt - Uses MD5 hashing to encrypt the salted password so it's save for storage
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
### Break down into end to end tests

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning


## Authors

* **Jose Costa** 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc

