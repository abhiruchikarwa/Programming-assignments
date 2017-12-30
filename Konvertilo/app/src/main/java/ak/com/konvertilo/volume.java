package ak.com.konvertilo;

public class volume {
    double x,y;
    public object mll (object ob)
    {
        x = ob.getA();
        y = (x / 1000);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object lml (object ob)
    {
        x = ob.getA();
        y = (x * 1000);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mloz(object ob)
    {
        x = ob.getA();
        y = (x / 29.5735);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object ozml(object ob)
    {
        x = ob.getA();
        y = (x * 29.5735 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mlpt(object ob)
    {
        x = ob.getA();
        y = (x / 473.176);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object ptml(object ob)
    {
        x = ob.getA();
        y = (x * 473.176 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mlgal(object ob)
    {
        x = ob.getA();
        y = (x / 3785.41 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object galml(object ob)
    {
        x = ob.getA();
        y = (x * 3785.41 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object loz(object ob)
    {
        x = ob.getA();
        y = (x * 33.814 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object ozl(object ob)
    {
        x = ob.getA();
        y = (x / 33.814  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object lpt(object ob)
    {
        x = ob.getA();
        y = (x * 2.11338 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object ptl(object ob)
    {
        x = ob.getA();
        y = (x / 2.11338 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object lgal(object ob)
    {
        x = ob.getA();
        y = (x / 3.78541 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object gall(object ob)
    {
        x = ob.getA();
        y = (x * 3.78541 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object ozpt(object ob)
    {
        x = ob.getA();
        y = (x / 16 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object ptoz(object ob)
    {
        x = ob.getA();
        y = (x * 16  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object ozgal(object ob)
    {
        x = ob.getA();
        y = (x / 128 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object galoz(object ob)
    {
        double x = ob.getA();
        double y = ob.getB();
        y = (x * 128  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object ptgal(object ob)
    {
        x = ob.getA();
        y = (x / 8 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object galpt(object ob)
    {
        x = ob.getA();
        y = (x * 8 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
}
