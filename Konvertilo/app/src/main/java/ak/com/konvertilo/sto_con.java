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

public class sto_con extends Activity {

    object ob = new object();
    object r=new object();
    Double a = 0.0 , b = 0.0;
    Integer f1, f2;
    storage st= new storage();
    private Spinner spinner1, spinner2;
    private static final String[]item = new String[]{"Byte" , "Kilobyte" , "Megabyte" , "Gigabyte", "Terabyte"};
    private EditText et1;
    private EditText et2;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sto_con);

        et1= (EditText) findViewById(R.id.etsto1);
        et2 = (EditText) findViewById(R.id.etsto2);


        ImageButton b1 = (ImageButton) findViewById(R.id.n_sto);
        ImageButton b2 = (ImageButton) findViewById(R.id.r_sto);




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
                        Toast.makeText(sto_con.this, "Enter a value.", Toast.LENGTH_SHORT).show();
                    }

                    else {
                        if (a == 0.0 && b != 0.0) {
                            ob.setA(0.0);
                            ob.setB(b);
                        } else if (a != 0.0 && b == 0.0) {
                            ob.setA(a);
                            ob.setB(0.0);
                        } else {
                            Toast.makeText(sto_con.this, "Reset the values first", Toast.LENGTH_SHORT).show();
                        }
                    }
                }catch (Exception e){
                    Log.d("AKEXC", e.toString());
                    //Toast.makeText(getApplicationContext(), e.getMessage(),Toast.LENGTH_SHORT).show();
                }
                if(f1==f2)
                {
                    Toast.makeText(sto_con.this , "Choose distinct parameters" , Toast.LENGTH_SHORT).show();
                }
                else
                {
                    if(f1==0&&f2==1)
                        r=st.bkb(ob);
                    if(f1==1&&f2==0)
                        r=st.kbb(ob);
                    if(f1==0&&f2==2)
                        r=st.bmb(ob);
                    if(f1==2&&f2==0)
                        r=st.mbb(ob);
                    if(f1==0&&f2==3)
                        r=st.bgb(ob);
                    if(f1==3&&f2==0)
                        r=st.gbb(ob);
                    if(f1==0&&f2==4)
                        r=st.btb(ob);
                    if(f1==4&&f2==0)
                        r=st.tbb(ob);
                    if(f1==1&&f2==2)
                        r=st.kbmb(ob);
                    if(f1==2&&f2==1)
                        r=st.mbkb(ob);
                    if(f1==1&&f2==3)
                        r=st.kbgb(ob);
                    if(f1==3&&f2==1)
                        r=st.gbkb(ob);
                    if(f1==1&&f2==4)
                        r=st.kbtb(ob);
                    if(f1==4&&f2==1)
                        r=st.tbkb(ob);
                    if(f1==2&&f2==3)
                        r=st.mbgb(ob);
                    if(f1==3&&f2==2)
                        r=st.gbmb(ob);
                    if(f1==2&&f2==4)
                        r=st.mbtb(ob);
                    if(f1==4&&f2==2)
                        r=st.tbmb(ob);
                    if(f1==3&&f2==4)
                        r=st.gbtb(ob);
                    if(f1==4&&f2==3)
                        r=st.tbgb(ob);

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

        spinner1 = (Spinner)findViewById(R.id.spsto1);
        spinner2 = (Spinner)findViewById(R.id.spsto2);
        ArrayAdapter<String>adapter1 = new ArrayAdapter<String>(sto_con.this,
                android.R.layout.simple_spinner_item,item);
        adapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        ArrayAdapter<String>adapter2 = new ArrayAdapter<String>(sto_con.this,
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
                Toast.makeText(sto_con.this , "Select something" , Toast.LENGTH_SHORT).show();
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
                Toast.makeText(sto_con.this , "Select something!" , Toast.LENGTH_SHORT).show();
            }
        });
    }
}
