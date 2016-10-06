/**
 * Flocking 
 * by Daniel Shiffman. Added WeatherUndergroundAPI functionality by Nick Bontrager. 
 * 
 * An implementation of Craig Reynold's Boids program to simulate
 * the flocking behavior of birds. Each boid steers itself based on 
 * rules of avoidance, alignment, and coherence.
 * 
 * Click the mouse to add a new boid.
 */

Flock flock;

JSONObject json2;
JSONObject current_observationParker;
import processing.pdf.*;
boolean savePDF = false;
int windx;
int windy;
int last = 0;
int m = 0;

  float temp_fParker;
  float wind_degreesParker;
  float pressure_inParker;
  float wind_kphParker;
  int currentwindspeed=2;
  float visibility_miParker;
  String winddirection;

void setup() {
  fullScreen ();
  //size (1000,900); 
  json2 = loadJSONObject("http://api.wunderground.com/api/xxx/conditions/q/CO/Parker.json");  //replace xxx with your API key
  current_observationParker = json2.getJSONObject("current_observation");
  flock = new Flock();
  // Add an initial set of boids into the system
  for (int i = 0; i < 150; i++) {
    flock.addBoid(new Boid(width/2,height/2));
  }
}

void draw() {
  
  if ( savePDF ) {
    beginRecord( PDF, "pdf/myartwork-####.pdf" );  //where to save your file
 }
  background(50);
  parkerCheck();
  flock.run();
  if ( savePDF ) {
  endRecord();
  savePDF = false;
 }
}

// Add a new boid into the System
void mousePressed() {
  flock.addBoid(new Boid(mouseX,mouseY));
}

void keyPressed()
{
  if ( key == 's' ) {   //which key to press when you want to save the image
  savePDF = true;
 }
}

void parkerCheck() {
  m = millis()-last;
    if(millis() > last+10000){
          last = millis();
          json2 = loadJSONObject("http://api.wunderground.com/api/0daeeb6a26909998/conditions/q/CO/Parker.json");
          current_observationParker = json2.getJSONObject("current_observation");
        // do something every 10 seconds
    }
  
  temp_fParker = current_observationParker.getFloat("temp_f");
  wind_degreesParker = current_observationParker.getFloat("wind_degrees");
  pressure_inParker = current_observationParker.getFloat("pressure_in");
  wind_kphParker = current_observationParker.getFloat("wind_kph");
  currentwindspeed = round(wind_kphParker);
  println(currentwindspeed);
  visibility_miParker = current_observationParker.getFloat("visibility_mi");
  winddirection = current_observationParker.getString("wind_dir");  //some objects are stored as strings
    
    
  
  textSize(22);
  text("Parker Colorado "+winddirection+"!", 10, 810);
  
  textSize(14);
  text("Wind (kph):" + wind_kphParker, 10, 820);
  
  
  switch(winddirection) {
  case "N": 
    windx = 960;
    windy = 0;
    break;
    
 case "NNE": 
    windx = 1440;
    windy = 0;
    break;
    
 case "NE": 
    windx = 1920;
    windy = 0;
    break;
    
 case "ENE": 
    windx = 1920;
    windy = 270;
    break;
    
  case "E": 
    windx = 1920;
    windy = 540;
    break;
    
    case "ESE": 
    windx = 1920;
    windy = 810;
    break;
    
    case "SE": 
    windx = 1920;
    windy = 1080;
    break;
    
    case "SSE": 
    windx = 1440;
    windy = 1080;
    break;
    
    case "S": 
    windx = 960;
    windy = 1080;
    break;
    
    case "SSW": 
    windx = 480;
    windy = 1080;
    break;
    
    case "SW": 
    windx = 0;
    windy = 1080;
    break;
    
    case "WSW": 
    windx = 0;
    windy = 810;
    break;
    
    case "W": 
    windx = 0;
    windy = 540;
    break;
    
    case "WNW": 
    windx = 0;
    windy = 270;
    break;
    
    case "NW": 
    windx = 0;
    windy = 0;
    break;
    
    case "NNW": 
    windx = 480;
    windy = 0;
    break;
    
    default:
    break;
}
    
}