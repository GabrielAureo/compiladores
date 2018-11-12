var a, b, i, j;
console >> a;
console >> b;
for i in [4..a] begin
  for j in [i*2..b*b] begin
    console << "[" << i << ",";
    if i*i % j*j == 0 then
      console << j << "] ";
  end;
  console << "(" << b*b << ")" << endl;
end;