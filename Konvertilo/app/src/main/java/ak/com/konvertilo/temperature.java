package ak.com.konvertilo;
public class temperature {
    double x, y;
    public object celfah(object ob)
    {
        x = ob.getA();
        y = (x * 9/5) + 32;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object fahcel(object ob)
    {
        x = ob.getA();
        y = (x - 32) * 5/9;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object celkel(object ob)
    {
        x = ob.getA();
        y = x + 273.15;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kelcel(object ob)
    {
        x = ob.getA();
        y = x - 273.15;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object fahkel(object ob)
    {
        x = ob.getA();
        y = (x-32)/(1.8)+273.15;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kelfah(object ob)
    {
        x = ob.getA();
        y = (x-273.15)*1.8+32;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
}
