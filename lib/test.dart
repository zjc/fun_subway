void main(){
   var uri = new Uri(scheme: "https",host: "www.baidu.com");

   uri = uri.resolve("query=123");

   print(uri.toString());
}