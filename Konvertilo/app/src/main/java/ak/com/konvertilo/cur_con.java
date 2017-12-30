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

public class cur_con extends Activity {

    object ob = new object();
    object r = new object();
    Double a = 0.0, b = 0.0;
    Integer f1, f2;
    currency cu = new currency();
    private Spinner spinner1, spinner2;
    private static final String[] item = new String[]{"Rupee", "Yen", "Dollar", "Pound", "Euro"};
    private EditText et1;
    private EditText et2;

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cur_con);

        et1 = (EditText) findViewById(R.id.etcur1);
        et2 = (EditText) findViewById(R.id.etcur2);

        ImageButton b1 = (ImageButton) findViewById(R.id.n_cur);
        ImageButton b2 = (ImageButton) findViewById(R.id.r_cur);

        b1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                try {
                    a = Double.parseDouble(et1.getText().toString());
                    b = Double.parseDouble(et2.getText().toString());

                } catch (Exception e) {
                    // Toast.makeText(length_con.this , e.toString() , Toast.LENGTH_LONG).show();
                }
                try {
                    if (a.equals(null) && b.equals(null)) {
                        Toast.makeText(cur_con.this, "Enter a value.", Toast.LENGTH_SHORT).show();
                    } else {
                        if (a == 0.0 && b != 0.0) {
                            ob.setA(0.0);
                            ob.setB(b);
                        } else if (a != 0.0 && b == 0.0) {
                            ob.setA(a);
                            ob.setB(0.0);
                        } else {
                            Toast.makeText(cur_con.this, "Reset the values first", Toast.LENGTH_SHORT).show();
                        }
                    }
                } catch (Exception e) {
                    Log.d("AKEXC", e.toString());
                    //Toast.makeText(getApplicationContext(), e.getMessage(),Toast.LENGTH_SHORT).show();
                }
                if (f1 == f2) {
                    Toast.makeText(cur_con.this, "Choose distinct parameters", Toast.LENGTH_SHORT).show();
                } else {
                    if (f1 == 0 && f2 == 1)
                        r = cu.inrjpy(ob);
                    if (f1 == 1 && f2 == 0)
                        r = cu.jpyinr(ob);
                    if (f1 == 0 && f2 == 2 )
                        r = cu.inrusd(ob);
                    if(f1 == 2 && f2 == 0)
                        r = cu.usdinr(ob);
                    if (f1 == 0 && f2 == 3)
                        r = cu.inrbp(ob);
                    if(f1 == 3 && f2 == 0)
                        r = cu.bpinr(ob);
                    if (f1 == 0 && f2 == 4)
                        r = cu.inreur(ob);
                    if(f1 == 4 && f2 == 0)
                        r = cu.eurinr(ob);
                    if (f1 == 1 && f2 == 2)
                        r = cu.jpyusd(ob);
                    if(f1 == 2 && f2 == 1)
                        r = cu.usdjpy(ob);
                    if (f1 == 1 && f2 == 3)
                        r = cu.jpybp(ob);
                    if(f1 == 3 && f2 == 1)
                        r = cu.bpjpy(ob);
                    if (f1 == 1 && f2 == 4)
                        r = cu.jpyeur(ob);
                    if(f1 == 4 && f2 == 1)
                        r = cu.eurjpy(ob);
                    if (f1 == 2 && f2 == 3)
                        r = cu.usdbp(ob);
                    if(f1 == 3 && f2 == 2)
                        r = cu.bpusd(ob);
                    if (f1 == 2 && f2 == 4)
                        r = cu.usdeur(ob);
                    if(f1 == 4 && f2 == 2)
                        r = cu.eurusd(ob);
                    if (f1 == 3 && f2 == 4)
                        r = cu.bpeur(ob);
                    if(f1 == 4 && f2 == 3)
                        r = cu.eurbp(ob);

                    et1.setText(r.getA() + "");
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

        spinner1 = (Spinner) findViewById(R.id.spcur1);
        spinner2 = (Spinner) findViewById(R.id.spcur2);
        ArrayAdapter<String> adapter1 = new ArrayAdapter<String>(cur_con.this,
                android.R.layout.simple_spinner_item, item);
        adapter1.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        ArrayAdapter<String> adapter2 = new ArrayAdapter<String>(cur_con.this,
                android.R.layout.simple_spinner_item, item);
        adapter2.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinner1.setAdapter(adapter1);
        spinner1.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                switch (position) {
                    case 0:
                        f1 = 0;
                        break;
                    case 1:
                        f1 = 1;
                        break;
                    case 2:
                        f1 = 2;
                        break;
                    case 3:
                        f1 = 3;
                        break;
                    case 4:
                        f1 = 4;
                        break;


                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(cur_con.this, "Select something", Toast.LENGTH_SHORT).show();
            }
        });
        spinner2.setAdapter(adapter2);
        spinner2.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                switch (position) {
                    case 0:
                        f2 = 0;
                        break;
                    case 1:
                        f2 = 1;
                        break;
                    case 2:
                        f2 = 2;
                        break;
                    case 3:
                        f2 = 3;
                        break;
                    case 4:
                        f2 = 4;
                        break;
                }
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {
                Toast.makeText(cur_con.this, "Select something!", Toast.LENGTH_SHORT).show();
            }
        });
    }
}

