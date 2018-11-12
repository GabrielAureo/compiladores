#include <string>

using namespace std;

struct Lista {
  bool sublista;
  string valorString;
  Lista* valorSublista;
  Lista* proximo;
};

Lista* geraLista() {
  Lista *p0, *p1, *p2, *p3, *p4, *p5, *p6;

  p0 = new Lista;
  p0->sublista = false;
  p0->valorString = "1";
  p0->valorSublista = nullptr;

  p1 = new Lista;
  p1->sublista = false;
  p1->valorString = "2";
  p1->valorSublista = nullptr;

  p2 = new Lista;
  p2->sublista = false;
  p2->valorString = "3";
  p2->valorSublista = nullptr;

  p3 = new Lista;
  p3->sublista = false;
  p3->valorString = "4";
  p3->valorSublista = nullptr;

  p4 = new Lista;
  p4->sublista = false;
  p4->valorString = "5";
  p4->valorSublista = nullptr;

  p4->proximo = nullptr;

  p3->proximo = p4;

  p5 = new Lista;
  p5->sublista = true;
  p5->valorString = "";
  p5->valorSublista = p3;

  p6 = new Lista;
  p6->sublista = false;
  p6->valorString = "6";
  p6->valorSublista = nullptr;

  p6->proximo = nullptr;

  p5->proximo = p6;

  p2->proximo = p5;

  p1->proximo = p2;

  p0->proximo = p1;

  return p0;
}
