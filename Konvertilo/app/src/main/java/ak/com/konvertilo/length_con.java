package ak.com.konvertilo;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.Spinner;
import android.widget.Toast;

public class length_con extends Activity {

    object ob = new object();
    object r=new object();
    Double a = 0.0 , b = 0.0;
    Integer f1, f2;
    length len= new length();
    private Spinner spinner1, spinner2;
    private static final String[]item = new String[]{"Inch" , "Foot" , "Mile" , "Yard", "Metre"};
    private EditText et1;
    private EditText et2;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_length_con);

         et1= (EditText) findViewById(R.id.takeval0);
         et2 = (EditText) findViewById(R.id.takeval);


        ImageButton b1 = (ImageButton) findViewById(R.id.n_len);
        ImageButton b2 = (ImageButton) findViewById(R.id.r_len);




        b1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {

                try
                {
                    a =  Double.parseDouble(et1.getText().toString());
                    b = Double.parseDouble(et2.getText().toString());
                }
                catch (Exception e)
                {
                   // Toast.makeText(length_con.this , e.toString() , Toast.LENGTH_LONG).show();
                }
                try {
                    if (a.equals(null) && b.equals(null)) {
                        Toast.makeText(length_con.this, "Enter a value.", Toast.LENGTH_SHORT).show();
                    }

                    else {
                        if (a == 0.0 && b != 0.0) {
                            ob.setA(0.0);
                            ob.setB(b);
                        } else if (a != 0.0 && b == 0.0) {
                            ob.setA(a);
                            ob.setB(0.0);
                        } else {
                            Toast.makeText(length_con.this, "Reset the values first", Toast.LENGTH_SHORT).show();
                        }
                    }
                }catch (Exception e){
                        Log.d("AKEXC", e.toString());
                    //Toast.makeText(getApplicationContext(), e.getMessage(),Toast.LENGTH_SHORT).show();
                    }
                if(f1==f2)
                {
                    Toast.makeText(length_con.this , "Choose distinct parameters" , Toast.LENGTH_SHORT).show();
                }
                else
                {
                    if(f1==0&&f2==1)
                        r=len.inchfoot(ob);
                    if(f1==1&&f2==0)
                        r = len.footinch(ob);
                    if(f1==0&&f2==2)
                        r=len.inchmile(ob);
                    if(f1==2&&f2==0)
                        r = len.mileinch(ob);
                    if(f1==0&&f2==3)
                        r= len.inchyard(ob);
                    if(f1==3&&f2==0)
                        r=len.yardinch(ob);
                    if(f1==0&&f2==4)
                        r=len.inchmetre(ob);
                    if(f1==4&&f2==0)
                        r = len.metreinch(ob);
                    if(f1==1&&f2==2)
                        r=len.footmile(ob);
                    if(f1==2&&f2==1)
                        r = len.milefoot(ob);
                    if(f1==1&&f2==3)
                        r=len.footyard(ob);
                    if(f1==3&&f2==1)
                        r = len.yardfoot(ob);
                    if(f1==1&&f2==4)
                        r=len.footmetre(ob);
                    if(f1==4&&f2==1)
                        r=len.metrefoot(ob);
                    if(f1==2&&f2==3)
                        r=len.mileyard(ob);
                    if(f1==3&&f2==2)
                        r=len.yardmile(ob);
                    if(f1==2&&f2==4)
                        r=len.milemetre(ob);
                    if(f1==4&&f2==2)
                        r=len.metremile(ob);
                    if(f1==3&&f2==4)
                        r=len.yardmetre(ob);
                    if(f1==4&&f2==3)
                        r=len.metreyard(ob);

                    et1.setText(r.getA()+"");
                    et2.setText(r.getB() + "");
                }
            }
        });

        b2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                et1.setText("");
                et2.setText("");
            }
        });

        spinner1 = (Spinner)findViewById(R.id.splen1);
        spinner2 = (Spinner)findViewById(R.id.splen2);
        ArrayAdapter<String>adapter1 = new ArrayAdapter<String>(length_con.this,
                android.R.layout.simple_spinner_item,item);
        adapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        ArrayAdapter<String>adapter2 = new ArrayAdapter<String>(length_con.this,
                android.R.layout.simple_spinner_item,item);
        adapter2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner1.setAdapter(adapter1);
        spinner1.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                switch (position) {
                    case 0: f1 = 0;
                        break;
                    case 1: f1 = 1;
                        break;
                    case 2: f1 = 2;
                        break;
                    case 3: f1 = 3;
                        break;
                    case 4: f1 = 4;
                        break;


                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(length_con.this , "Select something" , Toast.LENGTH_SHORT).show();
            }
        });
        spinner2.setAdapter(adapter2);
        spinner2.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                switch (position) {
                    case 0: f2 = 0;
                        break;
                    case 1: f2 = 1;
                        break;
                    case 2: f2 = 2;
                        break;
                    case 3: f2 = 3;
                        break;
                    case 4: f2 = 4;
                        break;
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(length_con.this , "Select something!" , Toast.LENGTH_SHORT).show();
            }
        });
    }

}
