package ak.com.konvertilo;


public class currency {
    double x,y;
    public object inrjpy(object ob)
    {
        x = ob.getA();
        y = x * 1.84 ;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object jpyinr(object ob)
    {
        x = ob.getA();
        y = x * 0.54;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object inrusd(object ob)
    {
        x = ob.getA();
        y = x * 0.015;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object usdinr(object ob)
    {
        x = ob.getA();
        y = x * 65.03;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object inrbp(object ob)
    {
        x = ob.getA();
        y = x * 0.01;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object bpinr(object ob)
    {
        x = ob.getA();
        y = x * 100.44;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object inreur(object ob)
    {
        x = ob.getA();
        y = x * 0.014;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object eurinr(object ob)
    {
        x = ob.getA();
        y = x * 73.78;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object jpyusd(object ob)
    {
       x = ob.getA();
        y = x * 0.0083;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object usdjpy(object ob)
    {
        x = ob.getA();
        y = x * 119.84;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object jpybp(object ob)
    {
        x = ob.getA();
        y = x * 0.0054;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object bpjpy(object ob)
    {
        x = ob.getA();
        y = x * 185.14;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object jpyeur(object ob)
    {
        x = ob.getA();
        y = x * 0.0074;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object eurjpy(object ob)
    {
        x = ob.getA();
        y = x * 135.95;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object usdbp(object ob)
    {
        x = ob.getA();
        y = x * 0.65;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object bpusd(object ob)
    {
        x = ob.getA();
        y = x * 1.54;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object usdeur(object ob)
    {
        x = ob.getA();
        y = x * 0.88;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object eurusd(object ob)
    {
        x = ob.getA();
        y = x * 1.13;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object bpeur(object ob)
    {
        x = ob.getA();
        y = x * 1.36;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object eurbp(object ob)
    {
        x = ob.getA();
        y = x * 0.73;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }



}
