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

public class temp_con extends Activity {

    object ob = new object();
    object r=new object();
    Double a = 0.0 , b = 0.0;
    Integer f1, f2;
    temperature te= new temperature();
    private Spinner spinner1, spinner2;
    private static String[]item = new String[]{"Celsius" , "Fahrenheit" , "Kelvin" };
    private EditText et1;
    private EditText et2;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_temp_con);

        et1= (EditText) findViewById(R.id.ettemp1);
        et2 = (EditText) findViewById(R.id.ettemp2);

        ImageButton b1 = (ImageButton) findViewById(R.id.n_temp);
        ImageButton b2 = (ImageButton) findViewById(R.id.r_temp);

        b1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {

                try
                {
                    a = Double.parseDouble(et1.getText().toString());
                    b = Double.parseDouble(et2.getText().toString());
                }
                catch (Exception e)
                {
                    // Toast.makeText(temp_con.this , e.toString() , Toast.LENGTH_LONG).show();
                }
                try {
                    if (a.equals(null) && b.equals(null)) {
                        Toast.makeText(temp_con.this, "Enter a value.", Toast.LENGTH_SHORT).show();
                    }

                    else {
                        if (a == 0.0 && b != 0.0) {
                            ob.setA(0.0);
                            ob.setB(b);
                        } else if (a != 0.0 && b == 0.0) {
                            ob.setA(a);
                            ob.setB(0.0);
                        } else {
                            Toast.makeText(temp_con.this, "Reset the values first", Toast.LENGTH_SHORT).show();
                        }
                    }
                }catch (Exception e){
                    Log.d("AKEXC", e.toString());
                    //Toast.makeText(getApplicationContext(), e.getMessage(),Toast.LENGTH_SHORT).show();
                }
                if(f1==f2)
                {
                    Toast.makeText(temp_con.this , "Choose distinct parameters" , Toast.LENGTH_SHORT).show();
                }
                else
                {
                    if(f1==0&&f2==1)
                        r=te.celfah(ob);
                    if(f1==1&&f2==0)
                        r=te.fahcel(ob);
                    if(f1==0&&f2==2)
                        r=te.celkel(ob);
                    if(f1==2&&f2==0)
                        r=te.kelcel(ob);
                    if(f1==1&&f2==2)
                        r=te.fahkel(ob);
                    if(f1==2&&f2==1)
                        r=te.kelfah(ob);

                    et1.setText(r.getA()+"");
                    et2.setText(r.getB()+"");
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

        spinner1 = (Spinner)findViewById(R.id.sptemp1);
        spinner2 = (Spinner)findViewById(R.id.sptemp2);
        ArrayAdapter<String>adapter1 = new ArrayAdapter<String>(temp_con.this,
                android.R.layout.simple_spinner_item,item);
        adapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        ArrayAdapter<String>adapter2 = new ArrayAdapter<String>(temp_con.this,
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

                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(temp_con.this , "Select something" , Toast.LENGTH_SHORT).show();
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

                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(temp_con.this , "Select something!" , Toast.LENGTH_SHORT).show();
            }
        });
    }

}
