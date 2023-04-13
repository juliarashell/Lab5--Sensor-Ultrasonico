import processing.serial.*;

Serial puerto;
String serialAngulo;
String serialDistancia;
String serialDatos;
float objetoDistancia;
int radarAngulo, radarDistancia;
int index=0;

void setup(){
  size (1280, 720);
  
  String puertoUtilizado = "COM3";
  puerto = new Serial(this, puertoUtilizado, 9600);
  
  puerto.bufferUntil('#');
}

void draw(){
  noStroke();
  
  fill(0,4); 
  rect(0, 0, 1280, 720); 
  fill(10,255,10);
 
  //Radar Arcos y líneas  
  pushMatrix();  
  translate(640,666);
  noFill();
  strokeWeight(2);
  stroke(10,255,10);  
  arc(0,0,1200,1200,PI,TWO_PI);
  arc(0,0,934,934,PI,TWO_PI);
  arc(0,0,666,666,PI,TWO_PI);
  arc(0,0,400,400,PI,TWO_PI);
  strokeWeight(4);
  line(-640,0,640,0);
  line(0,0,-554,-320);
  line(0,0,-320,-554);
  line(0,0,0,-640);
  line(0,0,320,-554);
  line(0,0,554,-320);  
  popMatrix();
  
 
  // Líneas del radar
  pushMatrix();  
  strokeWeight(5);
  stroke(10,255,10); // color verde
  translate(640,666);
  line(0,0,640*cos(radians(radarAngulo)),-640*sin(radians(radarAngulo)));  
  popMatrix();

  // Objeto detectado, líneas de color rojo
  pushMatrix();  
  translate(640,666);
  strokeWeight(5);
  stroke(255,10,10); // color rojo
  objetoDistancia = radarDistancia*15;

  if(radarDistancia<40){  // si la distancia es menos de 40 cm
    line(objetoDistancia*cos(radians(radarAngulo)),-objetoDistancia*sin(radians(radarAngulo)),633*cos(radians(radarAngulo)),-633*sin(radians(radarAngulo)));
  }  
  popMatrix();
}

void serialEvent (Serial puerto){
  serialDatos = puerto.readStringUntil('#');
  serialDatos = serialDatos.substring(0,serialDatos.length()-1);
  
  index = serialDatos.indexOf("*");
  
  serialAngulo= serialDatos.substring(0, index);
  serialDistancia= serialDatos.substring(index+1, serialDatos.length());
  
  radarAngulo = int(serialAngulo);
  radarDistancia = int(serialDistancia);
}
