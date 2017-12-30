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

public class mass_con extends Activity {

    object ob = new object();
    object r=new object();
    Double a = 0.0 , b = 0.0;
    Integer f1, f2;
    mass ms= new mass();
    private Spinner spinner1, spinner2;
    private static final String[]item = new String[]{"Ounce" , "Pound" , "Gram" , "Kilogram"};
    private EditText et1;
    private EditText et2;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mass_con);

        et1= (EditText) findViewById(R.id.etmass1);
        et2 = (EditText) findViewById(R.id.etmass2);

        ImageButton b1 = (ImageButton) findViewById(R.id.n_mass);
        ImageButton b2 = (ImageButton) findViewById(R.id.r_mass);

        b1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {

                try
                {
                    a = Double.parseDouble(et1.getText().toString());
                    b = Double.parseDouble(et2.getText().toString());
                }
                catch (Exception e)
                {
                    // Toast.makeText(msgth_con.this , e.toString() , Toast.LENGTH_LONG).show();
                }
                try {
                    if (a.equals(null) && b.equals(null)) {
                        Toast.makeText(mass_con.this, "Enter a value.", Toast.LENGTH_SHORT).show();
                    }

                    else {
                        if (a == 0.0 && b != 0.0) {
                            ob.setA(0.0);
                            ob.setB(b);
                        } else if (a != 0.0 && b == 0.0) {
                            ob.setA(a);
                            ob.setB(0.0);
                        } else {
                            Toast.makeText(mass_con.this, "Reset the values first", Toast.LENGTH_SHORT).show();
                        }
                    }
                }catch (Exception e){
                    Log.d("AKEXC", e.toString());
                    //Toast.makeText(getApplicationContext(), e.getMessage(),Toast.LENGTH_SHORT).show();
                }
                if(f1==f2)
                {
                    Toast.makeText(mass_con.this , "Choose distinct parameters" , Toast.LENGTH_SHORT).show();
                }
                else
                {
                    if(f1==0&&f2==1)
                        r=ms.ouncepound(ob);
                    if(f1==1&&f2==0)
                        r=ms.poundounce(ob);
                    if(f1==0&&f2==2)
                        r=ms.ouncegram(ob);
                    if(f1==2&&f2==0)
                        r=ms.gramounce(ob);
                    if(f1==0&&f2==3)
                        r=ms.ouncekg(ob);
                    if(f1==3&&f2==0)
                        r=ms.kgounce(ob);
                    if(f1==1&&f2==2)
                        r=ms.poundgram(ob);
                    if(f1==2&&f2==1)
                        r=ms.grampound(ob);
                    if(f1==1&&f2==3)
                        r=ms.poundkg(ob);
                    if(f1==3&&f2==1)
                        r=ms.kgpound(ob);
                    if(f1==2&&f2==3)
                        r=ms.gramkg(ob);
                    if(f1==3&&f2==2)
                        r=ms.kggram(ob);

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

        spinner1 = (Spinner)findViewById(R.id.spmass1);
        spinner2 = (Spinner)findViewById(R.id.spmass2);
        ArrayAdapter<String>adapter1 = new ArrayAdapter<String>(mass_con.this,
                android.R.layout.simple_spinner_item,item);
        adapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        ArrayAdapter<String>adapter2 = new ArrayAdapter<String>(mass_con.this,
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
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(mass_con.this , "Select something" , Toast.LENGTH_SHORT).show();
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
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(mass_con.this , "Select something!" , Toast.LENGTH_SHORT).show();
            }
        });
    }

}
