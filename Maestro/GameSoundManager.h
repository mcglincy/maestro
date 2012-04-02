#import "SimpleAudioEngine.h"

//#define SOUND_CRASH @"crash.wav"
//#define SOUND_DEFEAT @"defeat.wav"
#define SOUND_TEAR1 @"teardrop_1.wav"
#define SOUND_TEAR2 @"teardrop_2.wav"
#define SOUND_TEAR_CASE @"tear_in_case.wav"
#define SOUND_STORE_REGISTER @"store_register.wav"
#define SOUND_MENU_1 @"menu_1.wav"
#define SOUND_CRYING @"crying_4.wav"

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
    CDLongAudioSource *leftChannel;
    CDLongAudioSource *rightChannel;
    BOOL stopMaestroAfterNextLoop_;
    BOOL maestroPlaying_;
}

@property (readonly) tGameSoundState state;
@property (readonly) SimpleAudioEngine *soundEngine;
@property (readwrite) int nextMaestroTrack;
@property (readwrite) BOOL loopMaestroTrack;
@property (readonly) int numMaestroTracks;
@property (readwrite) float maestroStartDelay;

+ (GameSoundManager*)sharedInstance;
-(void) setup;
-(void) fadeOutMusic;
-(void) playMaestro;
-(void) playMaestroWithDelay : (float) delay ;
-(void) stopMaestroAfterNextLoop;
-(void) stopMaestro;

@end
