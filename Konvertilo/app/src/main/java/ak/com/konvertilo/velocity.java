package ak.com.konvertilo;

public class velocity {
    double x,y;
    public object mpskmph(object ob)
    {
        x = ob.getA();
        y = (x * 3.6);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kmphmps(object ob)
    {
        x = ob.getA();
        y = (x / 3.6);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mpsmph(object ob)
    {
        x = ob.getA();
        y = (x * 2.2369363);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mphmps(object ob)
    {
        x = ob.getA();
        y = (x / 2.2369363);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kmphmph(object ob)
    {
        x = ob.getA();
        y = (x / 1.6093439942836 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mphkmph(object ob)
    {
        x = ob.getA();
        y = (x * 1.6093439942836 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }

}
