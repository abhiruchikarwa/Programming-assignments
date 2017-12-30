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

public class vol_con extends Activity {

    object ob = new object();
    object r=new object();
    Double a = 0.0 , b = 0.0;
    Integer f1, f2;
    volume vol= new volume();
    private Spinner spinner1, spinner2;
    private static final String[]item = new String[]{"Millilitre" ,"Litre" , "Ounce", "Pint" , "Gallon"};
    private EditText et1;
    private EditText et2;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_vol_con);

        et1= (EditText) findViewById(R.id.etvol1);
        et2 = (EditText) findViewById(R.id.etvol2);


        ImageButton b1 = (ImageButton) findViewById(R.id.n_vol);
        ImageButton b2 = (ImageButton) findViewById(R.id.r_vol);




        b1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {

                try
                {
                    a =  Double.parseDouble(et1.getText().toString());
                    b = Double.parseDouble(et2.getText().toString());
                }
                catch (Exception e)
                {
                    // Toast.makeText(volgth_con.this , e.toString() , Toast.volGTH_LONG).show();
                }
                try {
                    if (a.equals(null) && b.equals(null)) {
                        Toast.makeText(vol_con.this, "Enter a value.", Toast.LENGTH_SHORT).show();
                    }

                    else {
                        if (a == 0.0 && b != 0.0) {
                            ob.setA(0.0);
                            ob.setB(b);
                        } else if (a != 0.0 && b == 0.0) {
                            ob.setA(a);
                            ob.setB(0.0);
                        } else {
                            Toast.makeText(vol_con.this, "Reset the values first", Toast.LENGTH_SHORT).show();
                        }
                    }
                }catch (Exception e){
                    Log.d("AKEXC", e.toString());
                    //Toast.makeText(getApplicationContext(), e.getMessage(),Toast.volGTH_SHORT).show();
                }
                if(f1==f2)
                {
                    Toast.makeText(vol_con.this , "Choose distinct parameters" , Toast.LENGTH_SHORT).show();
                }
                else
                {
                    if(f1==0&&f2==1)
                        r=vol.mll(ob);
                    if(f1==1&&f2==0)
                        r=vol.lml(ob);
                    if(f1==0&&f2==2)
                        r=vol.mloz(ob);
                    if(f1==2&&f2==0)
                        r=vol.ozml(ob);
                    if(f1==0&&f2==3)
                        r=vol.mlpt(ob);
                    if(f1==3&&f2==0)
                        r=vol.ptml(ob);
                    if(f1==0&&f2==4)
                        r=vol.mlgal(ob);
                    if(f1==4&&f2==0)
                        r=vol.galml(ob);
                    if(f1==1&&f2==2)
                        r=vol.loz(ob);
                    if(f1==2&&f2==1)
                        r=vol.ozl(ob);
                    if(f1==1&&f2==3)
                        r=vol.lpt(ob);
                    if(f1==3&&f2==1)
                        r=vol.ptl(ob);
                    if(f1==1&&f2==4)
                        r=vol.lgal(ob);
                    if(f1==4&&f2==1)
                        r=vol.gall(ob);
                    if(f1==2&&f2==3)
                        r=vol.ozpt(ob);
                    if(f1==3&&f2==2)
                        r=vol.ptoz(ob);
                    if(f1==2&&f2==4)
                        r=vol.ozgal(ob);
                    if(f1==4&&f2==2)
                        r=vol.galoz(ob);
                    if(f1==3&&f2==4)
                        r=vol.ptgal(ob);
                    if(f1==4&&f2==3)
                        r=vol.galpt(ob);

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

        spinner1 = (Spinner)findViewById(R.id.spvol1);
        spinner2 = (Spinner)findViewById(R.id.spvol2);
        ArrayAdapter<String>adapter1 = new ArrayAdapter<String>(vol_con.this,
                android.R.layout.simple_spinner_item,item);
        adapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        ArrayAdapter<String>adapter2 = new ArrayAdapter<String>(vol_con.this,
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
                Toast.makeText(vol_con.this , "Select something" , Toast.LENGTH_SHORT).show();
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
                Toast.makeText(vol_con.this , "Select something!" , Toast.LENGTH_SHORT).show();
            }
        });
    }

}
