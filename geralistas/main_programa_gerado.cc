#include <iostream>
#include <string>

using namespace std;

struct Lista {
  bool sublista; 
  string valorString;
  Lista* valorSublista;
  Lista* proximo;  
};

extern Lista* geraLista();

string print( Lista* l ) {
    string result;
    
    if( l != nullptr ) {
      if( l->sublista ) 
          result = "( " + print( l->valorSublista ) + " )";
      else
	result = l->valorString;
      
      if( l->proximo != nullptr )
        result += ", " + print( l->proximo );
    }

    return result;
}


int main() {
    
    cout << print( geraLista() ) << endl;
    
    return 0;
}