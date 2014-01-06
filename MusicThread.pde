class MusicThread extends Thread {
  boolean running;
    
  // note values and the actual sequence:
  final float F = 174.614;
  final float C = 261.626;
  final float E = 329.628;
  final float rest = 0.0;
  float[] sequence = { C, E, rest, E, F, C, E, F, F, E, C, C, rest, C, E };

  int currentNote;
  float bpm;
  
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
    if ( newBPM != bpm ) {
      //println( newBPM + " BPM" );
      bpm = newBPM;
      out.setTempo( bpm );
    }
  }
  
  // override "run()"
  void run () {
    while ( running ) {
      
      float secPerBeat = 60.0 / bpm;
      
      // keeps the loop gooing
      if ( currentNote < ( sequence.length - 1 ) ) currentNote++;
      else currentNote = 0;
 
      // not sure about the best practice here, but
      // there could be a pre-made set of 3 of these instead of instantiating a
      // new one every tick, if that was a better idea      
      SineInstrument instrument = new SineInstrument ( sequence[ currentNote ] );
      out.playNote( 0, 1, instrument );
      
      delay( ceil( 1000 * secPerBeat ) );
    }
  }
}
