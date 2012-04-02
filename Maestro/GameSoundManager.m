
#import "GameSoundManager.h"
#import "CDXPropertyModifierAction.h"
#import "GameClock.h"

@interface GameSoundManager (PrivateMethods)
-(void) asynchronousSetup;
-(void) preload;
@end

@implementation GameSoundManager

//TODO: modify this method to load the sounds for your game that you want preloaded at start up.
//If you don't preload your sounds there will be a delay before they are played the first time while the sound data
//is loaded to the playback buffer
-(void) preload {
    [soundEngine_ preloadEffect:SOUND_TEAR1];
    [soundEngine_ preloadEffect:SOUND_TEAR2];
    [soundEngine_ preloadEffect:SOUND_TEAR_CASE];
    [soundEngine_ preloadEffect:SOUND_STORE_REGISTER];
    [soundEngine_ preloadEffect:SOUND_MENU_1];
    
	//Preload the background music too but there is no point in preloading multiple background music files so only
	//preload the first one you will play
	[soundEngine_ preloadBackgroundMusic:@"title.wav"];
}

//TODO: modify these parameters to your own taste, e.g you may want a longer fade out or a different type of curve
-(void) fadeOutMusic {
    //if([self.soundEngine isBackgroundMusicPlaying]) {
    [CDXPropertyModifierAction fadeBackgroundMusic:2.0f finalVolume:0.0f curveType:kIT_SCurve shouldStop:YES];
    //}
}

-(void)cdAudioSourceDidFinishPlaying:(CDLongAudioSource *)audioSource {
    NSMutableString *logMessage = [NSMutableString stringWithString:@"sound finished. loop="];
    [logMessage appendString: (self.loopMaestroTrack) ? @"YES" : @"NO"];
    [logMessage appendString:@" stopMaestroAfterNextLoop_="];
    [logMessage appendString: (stopMaestroAfterNextLoop_) ? @"YES" : @"NO"];
    NSLog(logMessage);
    if (maestroPlaying_ && self.loopMaestroTrack) {
        [self playMaestro]; //play the next segment
    }
    
    if (stopMaestroAfterNextLoop_) {
        self.loopMaestroTrack = NO;
        stopMaestroAfterNextLoop_ = NO;
    }
}

@synthesize state = state_;
@synthesize nextMaestroTrack = nextMaestroTrack_;
@synthesize loopMaestroTrack = loopMaestroTrack_;
@synthesize numMaestroTracks = numMaestroTracks_;
@synthesize maestroStartDelay = maestroStartDelay_;
static GameSoundManager *sharedManager = nil;
static BOOL setupHasRun;

+ (GameSoundManager *) sharedInstance
{
	@synchronized(self)     {
		if (!sharedManager)
			sharedManager = [[GameSoundManager alloc] init];
		return sharedManager;
	}
	return nil;
}

-(id) init {
	if((self=[super init])) {
		soundEngine_ = nil;
		state_ = kGSUninitialised;
		setupHasRun = NO;
        nextMaestroTrack_ = 0;
        loopMaestroTrack_ = YES;
        stopMaestroAfterNextLoop_ = NO;
        numMaestroTracks_ = 4;
        maestroPlaying_ = NO;
	}
	return self;
}

-(void) setUpAudioManager {

	state_ = kGSAudioManagerInitialising;

	//Set up the mixer rate for sound engine. This must be done before the audio manager is initialised.
	//For performance Apple recommends having all your samples at the same sample rate and setting the mixer rate to the same value.
	//22050 Hz (CD_SAMPLE_RATE_MID) gives a nice balance between quality, performance and memory usage but you may want to
	//use a higher value for certain applications such as music games.
	[CDSoundEngine setMixerSampleRate:CD_SAMPLE_RATE_MID];

	//Initialise audio manager asynchronously as it can take a few seconds
	//The FXPlusMusicIfNoOtherAudio mode will check if the user is playing music and disable background music playback if
	//that is the case.
	[CDAudioManager initAsynchronously:kAMM_FxPlusMusicIfNoOtherAudio];
}

-(void) asynchronousSetup {

	[self setUpAudioManager];

	//Wait for the audio manager to initialise
	while ([CDAudioManager sharedManagerState] != kAMStateInitialised) {
		[NSThread sleepForTimeInterval:0.1];
	}

	state_ = kGSAudioManagerInitialised;
	//Note: although we are using SimpleAudioEngine this is built on top of the shared instance of CDAudioManager.
	//Therefore it is safe to access the shared instance of CDAudioManager if necessary.
	CDAudioManager *audioManager = [CDAudioManager sharedManager];
	if (audioManager.soundEngine == nil || audioManager.soundEngine.functioning == NO) {
		//Something has gone wrong - we have no audio
		state_ = kGSFailed;
	} else {

		//If you are using background music you probably want to do this. Basically it makes sure your background music
		//is paused and resumed properly when the application is resigned and resumed. Without it you will find that
		//music you had paused will restart even if you don't want it to or your music will start playing sooner than
		//you want.
		[audioManager setResignBehavior:kAMRBStopPlay autoHandle:YES];

		state_ = kGSLoadingSounds;

		soundEngine_ = [SimpleAudioEngine sharedEngine];

		[self preload];
        
        leftChannel=[audioManager audioSourceForChannel:kASC_Left];
        leftChannel.delegate=self;
        
        rightChannel=[audioManager audioSourceForChannel:kASC_Right];
        rightChannel.delegate=self; 
        
        
		state_ = kGSOkay;
	}
}

-(void) setup {

	//Make sure this only runs once
	if (setupHasRun) {
		return;
	} else {
		setupHasRun = YES;
	}

	//This code below is just using the NSOperation framework to run the asynchrounousSetup method in another thread.
	//Note: we do not use asynchronous loading to speed up loading, it is done so other things can occur while the loading
	//is happening. For example display a loading screen to the user.
	NSOperationQueue *queue = [[NSOperationQueue new] autorelease];
	NSInvocationOperation *asynchSetupOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(asynchronousSetup) object:nil];
	[queue addOperation:asynchSetupOperation];
    [asynchSetupOperation autorelease];

}

- (void)update:(ccTime)delay
{
    if ([[GameClock sharedInstance] currentTime] > self.maestroStartDelay) {
        [self playMaestro];
    }
}

-(void) playMaestro {
    maestroPlaying_ = YES;
    NSString *filename = [NSString stringWithFormat:@"Maestro_%i.wav", self.nextMaestroTrack];
    NSLog(@"Playing song %@", filename);
    [leftChannel load:filename]; //The audio engine will just rewind the clip if it notices the filename here is the same, so we don't need to be smart about it
    [leftChannel setVolume:1.0f];
    [leftChannel play];
}

-(void) stopMaestroAfterNextLoop {
    stopMaestroAfterNextLoop_ = YES;
    NSLog(@"STOP MAESTRO.");
}

-(void) stopMaestro {
    maestroPlaying_ = NO;
    [leftChannel stop];
}

-(void) playMaestroWithDelay: (float) delay {
}

-(SimpleAudioEngine *) soundEngine {

	if (self.state != kGSOkay && self.state != kGSFailed) {
		//The sound engine is still initialising, wait for it to finish up to a max of 10 seconds
		int waitCount = 0;
		while (self.state != kGSOkay && self.state != kGSFailed && waitCount < 100) {
			[NSThread sleepForTimeInterval:0.1];
			waitCount++;
		}
	}

	if (self.state == kGSOkay) {
		//We should only use sounds when the state is okay
		return soundEngine_;
	} else {
		//State wasn't okay, so we return nil
		return nil;
	}

}



@end
