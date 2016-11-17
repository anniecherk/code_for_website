int gcd3 ( int a, int b )
{
  if ( b == 0 ) 
    return a;
  return gcd3 ( b, a % b );
}
