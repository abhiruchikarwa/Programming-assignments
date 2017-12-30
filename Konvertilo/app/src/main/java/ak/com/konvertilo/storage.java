package ak.com.konvertilo;

public class storage {
    double x,y;
    public object bkb(object ob)
    {
        x = ob.getA();
        y = (x / 1024);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kbb(object ob)
    {
        x = ob.getA();
        y = (x * 1024);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mbb(object ob)
    {
        x = ob.getA();
        y = (x * 1024 * 1024);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object bmb(object ob)
    {
        x = ob.getA();
        y = (x / 1024 )/1024;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object gbb(object ob)
    {
        x = ob.getA();
        y = (x * 1024 * 1024 * 1024 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object bgb(object ob)
    {
        x = ob.getA();
        y = ((x / 1024 )/ 1024) /1024;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object tbb(object ob)
    {
        x = ob.getA();
        y = (x * 1024 *1024*1024*1024);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object btb(object ob)
    {
        x = ob.getA();
        y = (((x /1024)/1024)/1024)/1024;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mbkb(object ob)
    {
        x = ob.getA();
        y = (x * 1024 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kbmb(object ob)
    {
        x = ob.getA();
        y = (x / 1024  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object gbkb(object ob)
    {
        x = ob.getA();
        y = (x * 1024 * 1024 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kbgb(object ob)
    {
        x = ob.getA();
        y = (x /1024 )/1024;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object tbkb(object ob)
    {
        x = ob.getA();
        y = (x * 1024 *1024*1024 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object kbtb(object ob)
    {
        x = ob.getA();
        y = ((x/1024)/1024)/1024;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object gbmb(object ob)
    {
        x = ob.getA();
        y = (x * 1024 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mbgb(object ob)
    {
        x = ob.getA();
        y = (x/ 1024);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object tbmb(object ob)
    {
        x = ob.getA();
        y = (x * 1024*1024 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mbtb(object ob)
    {
        x = ob.getA();
        y = (x /1024)/1024;
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object tbgb(object ob)
    {
        x = ob.getA();
        y = (x * 1024 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object gbtb(object ob)
    {
        x = ob.getA();
        y = (x / 1024  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
}
