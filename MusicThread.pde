class MusicThread extends Thread {
  boolean running;
    
  // note values and the actual sequence:
  final float F = 174.614;
  final float C = 261.626;
  final float E = 329.628;
  final float someNote = 500.0;
  final float rest = 0.0;
  float[] sequence = { C, E, someNote, E, F, C, E, F, F, E, C, C, C, E };

//float[] sequence = { C, E, F, C, E, F, E, C, E };


  int currentNote;
  float bpm;
  
  boolean interrupt = false;
  
  MusicThread () {
    bpm = 60.0;
    running = false;
    currentNote = 0; // the index of the current note in the sequence
  }
  
  // override "start()"
  void start () {
    running = true;
    super.start();
  }
  
  float getBPM() {
    return bpm;
  }
  
  void setBPM( float newBPM ) {
    
    // REMOVE THIS
      if (newBPM > 10) {
        println( newBPM + " BPM" );
        bpm = newBPM;
      }
    
  }
  
  // override "run()"
  void run () {
    AudioOutput drone;
    drone = minim.getLineOut();
    drone.setGain(-5.0);
    drone.playNote( 0, 999999999, 65 );
    while ( running ) {     

      out.setTempo( bpm );
      float secPerBeat = 60.0 / bpm;
      
      // keeps the loop going
      if ( currentNote < ( sequence.length - 1 ) ) currentNote++;
      else currentNote = 0;
 
      // not sure about the best practice here, but
      // there could be a pre-made set of 3 of these instead of instantiating a
      // new one every tick, if that was a better idea      
      SineInstrument instrument = new SineInstrument ( sequence[ currentNote ] );
      out.playNote( 0, 1, instrument );

      //println( "note: " + currentNote );
      int delayCount = 0;
      while (delayCount < 1000 * (40/bpm)) {
        delay(1);
        delayCount++; 
      }
      
      //delay( ceil( 1000 * secPerBeat ) );
      
      
    }
  }
}
