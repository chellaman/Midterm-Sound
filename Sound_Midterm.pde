import processing.sound.*;
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.analysis.FFT;

FFT fft; //algorithm analyzing frequency
Minim minim;
AudioPlayer song;
int bands = 128;
PImage femaleEar;
PImage maleEar;
float earSizeX;
float earSizeY;
float maleEarSizeX;
float maleEarSizeY;
float heightY;

int[] hertzForSampling = new int[6]; //making hertz to analyze waveform

void setup() {
    
  minim = new Minim(this);
   song = minim.loadFile("her.mp3");
  femaleEar = loadImage("ci.png");
  maleEar = loadImage("ear.png");
  earSizeX = 80;
  earSizeY =90;
  maleEarSizeX = 60;
  maleEarSizeY = 80;
  
  hertzForSampling[0] = 250;
    hertzForSampling[1] = 300;
      hertzForSampling[2] = 320;
        hertzForSampling[3] = 500;
         hertzForSampling[4] = 1000;
            hertzForSampling[5] = 2000;
           background(174, 237, 239);
  //song.jump(10.3);
  song.play();
  // fft initializing the size of song
  fft = new FFT(song.bufferSize(), song.sampleRate());
 // frameRate(1);
}

void settings() {
  size(1000,500);
}

void draw() {
  //get frequency
     background(174, 237, 239);
     
     fft.forward(song.mix);
     
     for (int i = 0; i < hertzForSampling.length;i++){
       //map # of hertz on width of screen
     float pos = map(i,0,hertzForSampling.length,1,width);
     
     //draw line for freq of hertzForSampling[i]
     if(fft.getFreq( hertzForSampling[i] )*3 > 60){
     image(maleEar, pos, height/2 - fft.getFreq( hertzForSampling[i] )*2,80,80);
     } else {
       tint(255);
     image(femaleEar, pos+50, height/2 - fft.getFreq( hertzForSampling[i] )*2,80,80);
     }
      //   line( pos, height/2, pos, height/2 - fft.getFreq( hertzForSampling[i] )*3 );
   // line( pos, height/2, pos, height/2 + fft.getFreq( hertzForSampling[i] )*3 );
    text(hertzForSampling[i], pos, height/2); //which band is this one?
     println(fft.getFreq( hertzForSampling[i] )*3 );
     }
}