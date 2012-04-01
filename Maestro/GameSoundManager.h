#import "SimpleAudioEngine.h"

//#define SOUND_CRASH @"crash.wav"
//#define SOUND_DEFEAT @"defeat.wav"

typedef enum {
	kGSUninitialised,
	kGSAudioManagerInitialising,
	kGSAudioManagerInitialised,
	kGSLoadingSounds,
	kGSOkay,//only use when in this state
	kGSFailed
} tGameSoundState;

@interface GameSoundManager : NSObject <CDLongAudioSourceDelegate> {
	tGameSoundState state_;
	SimpleAudioEngine *soundEngine_;
    CDLongAudioSource *rightChannel;
}

@property (readonly) tGameSoundState state;
@property (readonly) SimpleAudioEngine *soundEngine;
@property (readwrite) int nextMaestroTrack;
@property (readonly) int numMaestroTracks;

+ (GameSoundManager*)sharedInstance;
-(void) setup;
-(void) fadeOutMusic;
-(void) playMaestro;

@end
