package jc.m3;


import java.io.IOException;
import java.util.Scanner;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {

        Server s= new Server();
        try {
            s.publish();
        } catch (IOException e) {
            //e.printStackTrace();
            System.out.println("Could not connect");
        }
    }
}
