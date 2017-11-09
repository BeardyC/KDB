package jc.m3;

import kdb.c;

import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.concurrent.ThreadLocalRandom;
public class RowGenerator {
    private int recordN;
    private long currTime = 54000000000000L;
    private Double[] bidPrices;
    private int[] bidSizes;

    public c.Flip generate(int recordN){
        this.recordN = recordN;


        c.Flip flip=new c.Flip(new c.Dict(
                new String[]{"dates","time","syms","markets","bidprices","askprices","bidsizes","asksizes"},
                new Object[]{
                        generateDate(),
                        generateTimestamp(),
                        genSyms(),
                        genMarkets(),
                        genBidPrices(),
                        genAskPrices(),
                        genBidSizes(),
                        genAskSizes()}));
        return flip;
    }

    private c.Timespan[] generateTimestamp(){
        c.Timespan[] x = new c.Timespan[this.recordN];
        long[] mylist = new long[this.recordN];
        for (int i = 0; i < this.recordN; i++) {
            mylist[i]= currTime + ThreadLocalRandom.current().nextLong(10000000L, 400000000L);
            //mylist[i]= currTime + ThreadLocalRandom.current().nextLong(10000000L, 1000000000L);
            currTime= mylist[i];
        }
        for (int i = 0; i < this.recordN ; i++) {
            x[i]= new c.Timespan(mylist[i]);
        }

        return x;
    }
    private String[] generateDate(){
        Date d = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
        String[] dateArray = new String[this.recordN];
        Arrays.fill(dateArray,sdf.format(d));
        return dateArray;
    }
    private String[] genSyms(){
        String[] markets = new String[this.recordN];
        Arrays.fill(markets,"`VOD");
        return markets;
    }
    private String[] genMarkets(){
        String[] markets = new String[this.recordN];
        Arrays.fill(markets,"NYSE");
        return markets;
    }
    private Double[] genBidPrices(){

        Double[] bidPrices = new Double[this.recordN];
        for (int i = 0; i < this.recordN; i++) {
            bidPrices[i]= 100 + ThreadLocalRandom.current().nextDouble(1, 50);
        }
        this.bidPrices = bidPrices;
        return bidPrices;
    }
    private Double[] genAskPrices(){

        Double[] askPrices = new Double[this.recordN];
        for (int i = 0; i < this.recordN; i++) {
            askPrices[i]= bidPrices[i] + ThreadLocalRandom.current().nextDouble(0, 2);
        }
        return askPrices;
    }
    private int[] genBidSizes(){

        int[] bidSizes = new int[this.recordN];
        for (int i = 0; i < this.recordN; i++) {
            bidSizes[i]= 2000 + (ThreadLocalRandom.current().nextInt(1, 500)*10);
        }
        this.bidSizes = bidSizes;
        return bidSizes;
    }
    private int[] genAskSizes(){

        int[] askPrices = new int[this.recordN];
        for (int i = 0; i < this.recordN; i++) {
            askPrices[i]= bidSizes[i] + ThreadLocalRandom.current().nextInt(0, 500);
        }
        return askPrices;
    }


}
