package jc.m3;

import kdb.c;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Random;
import java.util.Scanner;

public class Server {
    Random r = new Random();
	int port;
    
    public void publish() throws IOException {
        c connection= null;
        Scanner sc=new Scanner(System.in);
        System.out.println("Enter your username");
        String username =sc.next();
        System.out.println("Enter your password");
        String password =sc.next();
		File f = new File(System.getProperty("user.home")+"/kdbProject/tport.q");
		System.out.println(System.getProperty("user.home")+"/kdbProject/tport.q");
		System.out.println(f);
        if(f.exists() ) {
            FileReader fr = new FileReader(f);
            BufferedReader readFile = new BufferedReader(fr);
            String line = readFile.readLine();
            this.port= Integer.parseInt(line);
        }else{
            this.port=5010;
        }
		
		

        try {
            connection = new c("localhost",this.port,username+":"+password);
            RowGenerator row = new RowGenerator();
            //MAX RECORDS ~ 5000000 OR IT WILL CRASH;
            while (System.in.available() == 0) {
                int records=50+r.nextInt(100);
                c.Flip flip2 =row.generate(records);
                System.out.println("INFO Sending batch of "+records+" records");
                connection.ks(".u.upd","orders",flip2);
                try {
                    Thread.sleep(1000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }

        } catch (c.KException e) {
           // e.printStackTrace();
           System.out.println("ERROR. Could not connect.");
        } catch (IOException e) {
            //e.printStackTrace();
           System.out.println("ERROR. Could not connect.");
        }finally {
            //connection.close();
        }

    }


}
