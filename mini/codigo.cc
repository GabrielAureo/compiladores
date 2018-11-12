#include <string>
#include <iostream>

using namespace std;

int t0,t1,t2,t3,t4,t5,t6,t7,t8,t9;

int main(){
int a, b, i, j;
cin >> a;
cin >> b;
i = 4;
i3:
t9 = i > a;
if( t9) goto i4;
t0 = i*2;
t1 = b*b;
j = t0;
i1:
t7 = j > t1;
if( t7) goto i2;
cout << "[";
cout << i;
cout << ",";
t2 = i*i;
t3 = t2%j;
t4 = t3*j;
t5 = t4==0;
t6 = !t5;
if ( t6) goto i0;
cout << j;
cout << "] ";

i0:
j = j + 1;
goto i1;
i2:
cout << "(";
t8 = b*b;
cout << t8;
cout << ")";
cout << endl;
i = i + 1;
goto i3;
i4:
return 0; 

}
