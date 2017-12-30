package ak.com.konvertilo;

public class mass {
    double x,y;
    public object ouncepound(object ob)
    {
        x = ob.getA();
        y = (x / 16 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object poundounce(object ob)
    {
        x = ob.getA();
        y = (x * 16);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object ouncegram(object ob)
    {
        x = ob.getA();
        y = (x * 28.3495 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object gramounce(object ob)
    {
        x = ob.getA();
        y = (x * 0.035274  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object ouncekg(object ob)
    {
        x = ob.getA();
        y = (x * 0.0283495   );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kgounce(object ob)
    {
        x = ob.getA();
        y = (x * 35.274  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object poundgram(object ob)
    {
        x = ob.getA();
        y = (x * 453.592);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object grampound(object ob)
    {
        x = ob.getA();
        y = (x * 0.00220462 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object poundkg(object ob)
    {
        x = ob.getA();
        y = (x * 0.453592  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kgpound(object ob)
    {
        x = ob.getA();
        y = (x * 2.20462 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
   public object gramkg(object ob)
    {
        x = ob.getA();
        y = (x / 1000);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kggram(object ob)
    {
        x = ob.getA();
        y = (x * 1000 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }

}
