package ak.com.konvertilo;

public class length {
    double x, y;
    public object inchfoot(object ob)
    {
        x = ob.getA();
        y = (x / 12);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object footinch(object ob)
    {
        x = ob.getA();
        y = (x * 12);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
   public object inchmile(object ob)
   {
       x = ob.getA();
       y = (x / 63360);
       ob.setA(x);
       ob.setB(y);
       return ob;
   }
    public object mileinch(object ob)
    {
        x = ob.getA();
        y = (x * 63360 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object inchyard(object ob)
    {
        x = ob.getA();
        y = (x / 36 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object yardinch(object ob)
    {
        x = ob.getA();
        y = (x * 36 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object inchmetre(object ob)
    {
        x = ob.getA();
        y = (x / 39.3701 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object metreinch(object ob)
    {
        x = ob.getA();
        y = (x * 39.3701  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object footmile(object ob)
    {
        x = ob.getA();
        y = (x / 5280 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object milefoot(object ob)
    {
        x = ob.getA();
        y = (x * 5280  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object footyard(object ob)
    {
        x = ob.getA();
        y = (x / 3 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object yardfoot(object ob)
    {
        x = ob.getA();
        y = (x * 3 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object footmetre(object ob)
    {
        x = ob.getA();
        y = (x * 0.3048 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object metrefoot(object ob)
    {
        x = ob.getA();
        y = (x * 3.28084 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object mileyard(object ob)
    {
        x = ob.getA();
        y = (x * 1760 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object yardmile(object ob)
    {
        x = ob.getA();
        y = (x / 1760 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object milemetre(object ob)
    {
        x = ob.getA();
        y = (x * 1609.34 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object metremile(object ob)
    {
        x = ob.getA();
        y = (x * 0.000621371  );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object yardmetre(object ob)
    {
        x = ob.getA();
        y = (x * 0.9144 );
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
    public object metreyard(object ob)
    {
        x = ob.getA();
        y = (x * 1.09361);
        ob.setA(x);
        ob.setB(y);
        return ob;
    }
}
