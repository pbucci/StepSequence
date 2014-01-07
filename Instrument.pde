class SineInstrument implements Instrument {
  Oscil wave;
  Line ampEnv;
  
  SineInstrument ( float frequency ) {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 0.8f, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.
  void noteOn( float duration ) {
    // start the amplitude envelope
      
      float currentBPM = musicThread.getBPM();
      
      if ( currentBPM >= 60 ) {
        ampEnv.activate( duration, 0.8f, 0 );
      } else if ( currentBPM >= 30 ) {
        ampEnv.activate( duration, 0.8f, 0.45f );
      } else {
        ampEnv.activate( duration, 0.8f, 0.8f );
      }
      
    // attach the oscil to the output so it makes sound
    wave.patch( out );
  }
  
  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff() {
    wave.unpatch( out );
  }
}
